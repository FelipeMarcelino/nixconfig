{
  config,
  pkgs,
  ocr-zettel-source,
  ...
}:

let
  projectPath = ocr-zettel-source;

  # O ambiente Python continua o mesmo.
  pythonEnv = pkgs.python313.withPackages (
    ps: with ps; [
      watchdog
      python-dotenv
      openai
      pymupdf
      pillow
      torch
      torchvision
      transformers
      sentencepiece
      onnxruntime
    ]
  );

  startScript = pkgs.writeShellScriptBin "start-ocr-zettel" ''
    #!${pkgs.bash}/bin/bash
    # 'set -x' imprime cada comando no log antes de executá-lo. Excelente para depuração!
    set -x 
    export OPENAI_API_KEY="$(cat ${config.sops.secrets.OPENAI_API_KEY.path})"

    # Executa o seu script Python.
    # OBS: Verifique se este caminho está correto dentro do seu repositório Git.
    ${pythonEnv}/bin/python ${projectPath}/src/ocr-zettel/main.py
  '';
in
{

  systemd.user.services.ocr-zettel-monitor = {
    Unit = {
      Description = "Monitor de OCR para notas Zettelkasten";
      After = [
        "sops-nix.service"
        "network-online.target"
      ];
      Requires = [ "sops-nix.service" ];
    };
    Service = {
      # O ExecStart agora usa o "projectPath" que vem do flake
      ExecStart = "${startScript}/bin/start-ocr-zettel";
      WorkingDirectory = projectPath;

      # A localização do .env continua a mesma, e isso é crucial,
      # pois o código fonte no Nix store é somente leitura.
      EnvironmentFile = config.sops.secrets.OPENAI_API_KEY.path;

      Restart = "always";
      RestartSec = "10s";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

}
