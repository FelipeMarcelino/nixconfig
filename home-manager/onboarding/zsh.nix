{
  config,
  pkgs,
  ...
}:

{
  programs.zsh.sessionVariables = {
    ARTIFACTORY_USERNAME = "felipe.marcelino";
    ARTIFACTORY_PASSWORD = "cmVmdGtuOjAxOjE3Njc4NzU0MjY6ZElxZkNvUzlmS1BTTVUzcVd0dHd2ZkhUMFBE";
    ARTIFACTORY_CONTEXTURL = "https://creditas.jfrog.io/artifactory";
    HOMEBREW_GITHUB_API_TOKEN = "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";
  };

  programs.zsh.initExtra = ''
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export PATH=~/Projects/cliditas/bin:$PATH
    export PATH=~/Projects/cliditas/include/linux:$PATH
  '';

}
