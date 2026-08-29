# Omnigent - meta-harness para orquestrar agentes de codigo (Claude Code, Codex, ...)
# https://github.com/omnigent-ai/omnigent
#
# O omnigent e um app Python cujas dependencias vao alem do que o nixpkgs oferece
# (cel-python, versoes novas de starlette/claude-agent-sdk...), entao ele e montado
# a partir do uv.lock deste diretorio com uv2nix, usando as wheels exatas do PyPI.
{
  lib,
  inputs,
  callPackage,
  runCommand,
  python312,
}:

let
  inherit (inputs) pyproject-nix uv2nix pyproject-build-systems;

  workspace = uv2nix.lib.workspace.loadWorkspace { workspaceRoot = ./.; };

  # Patch: shutil.copytree preserva as permissoes read-only do Nix store,
  # fazendo o write_text subsequente falhar com PermissionError.
  # Injetamos um chmod -R u+w no diretorio copiado logo apos o copytree.
  nixCopytreeFix = ''
    import subprocess as _sp, pathlib as _pl

    _orig_copytree = __import__('shutil').copytree
    def _nix_copytree(src, dst, *a, **kw):
        result = _orig_copytree(src, dst, *a, **kw)
        _sp.run(["chmod", "-R", "u+w", str(dst)], check=False)
        return result
    __import__('shutil').copytree = _nix_copytree
  '';

  pythonSet =
    (callPackage pyproject-nix.build.packages { python = python312; }).overrideScope
      (
        lib.composeManyExtensions [
          pyproject-build-systems.overlays.default
          (workspace.mkPyprojectOverlay { sourcePreference = "wheel"; })
          # Patch omnigent para corrigir PermissionError do copytree em ambientes Nix
          (final: prev: {
            omnigent = prev.omnigent.overrideAttrs (old: {
              postInstall = (old.postInstall or "") + ''
                site="$out/lib/python3.12/site-packages"
                cat > "$site/omnigent/_nix_copytree_fix.py" << 'PYEOF'
                ${nixCopytreeFix}
                PYEOF
                # Prepend o import do fix no __init__.py
                echo 'from omnigent._nix_copytree_fix import *  # noqa: F401,F403  # nix read-only fix' \
                  | cat - "$site/omnigent/__init__.py" > "$site/omnigent/__init__.py.tmp"
                mv "$site/omnigent/__init__.py.tmp" "$site/omnigent/__init__.py"
              '';
            });
          })
        ]
      );

  venv = pythonSet.mkVirtualEnv "omnigent-env" workspace.deps.default;
in
# O venv traz ~40 binarios das dependencias (fastapi, httpx, alembic, keyring...).
# Expomos apenas os dois entrypoints do omnigent para nao poluir o PATH.
runCommand "omnigent-${venv.version or "0.11.0"}"
  {
    inherit venv;
    meta = {
      description = "Meta-harness declarativo para orquestrar agentes de codigo";
      homepage = "https://github.com/omnigent-ai/omnigent";
      license = lib.licenses.asl20;
      mainProgram = "omnigent";
      platforms = lib.platforms.unix;
    };
    passthru = { inherit venv pythonSet; };
  }
  ''
    mkdir -p "$out/bin"
    for prog in omnigent omni; do
      ln -s "$venv/bin/$prog" "$out/bin/$prog"
    done
  ''
