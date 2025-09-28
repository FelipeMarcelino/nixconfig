# home.nix

# A assinatura da função mudou para receber "ocrZettelSource"
{
  config,
  pkgs,
  ocrZettelSource,
  ...
}:

let
  projectPath = ocrZettelSource;

  # O ambiente Python continua o mesmo.
  pythonEnv = pkgs.python3.withPackages (
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

in
{
  # ... outras configurações (ex: home.packages, etc)

  systemd.user.services.ocr-zettel-monitor = {
    Unit = {
      Description = "Monitor de OCR para notas Zettelkasten";
      After = [ "network-online.target" ];
    };
    Service = {
      # O ExecStart agora usa o "projectPath" que vem do flake
      ExecStart = "${pythonEnv}/bin/python ${projectPath}/main.py";
      WorkingDirectory = projectPath;

      # A localização do .env continua a mesma, e isso é crucial,
      # pois o código fonte no Nix store é somente leitura.
      EnvironmentFile = config.sops.secrets.OPENAI_API_KEY.path;

      Restart = "always";
      RestartSec = "5s";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Lembre-se de adicionar aqui suas outras configurações do home.nix
  home.stateVersion = "23.11"; # Ou a sua versão
}
