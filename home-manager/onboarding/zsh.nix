{
  config,
  pkgs,
  ...
}:
{
  programs.zsh.sessionVariables = {
    ARTIFACTORY_USERNAME = ''$(${pkgs.coreutils}/bin/cat ${
      config.sops.secrets."artifactory/username".path
    })'';
    ARTIFACTORY_PASSWORD = ''$(${pkgs.coreutils}/bin/cat ${
      config.sops.secrets."artifactory/password".path
    })'';
    ARTIFACTORY_CONTEXTURL = ''$(${pkgs.coreutils}/bin/cat ${
      config.sops.secrets."artifactory/contexturl".path
    })'';
    HOMEBREW_GITHUB_API_TOKEN = ''$(${pkgs.coreutils}/bin/cat ${
      config.sops.secrets."homebrew_github_api_token".path
    })'';
  };

  programs.zsh.initExtra = ''
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export PATH=~/Projects/cliditas/bin:$PATH
    export PATH=~/Projects/cliditas/include/linux:$PATH
  '';
}
