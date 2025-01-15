{
  config,
  pkgs,
  ...,
}:

{
  programs.zsh.sessionVariables = {
    ARTIFACTORY_USERNAME="felipe.marcelino";
    ARTIFACTORY_PASSWORD="cmVmdGtuOjAxOjE3Njc4NzU0MjY6ZElxZkNvUzlmS1BTTVUzcVd0dHd2ZkhUMFBE";
    ARTIFACTORY_CONTEXTURL="https://creditas.jfrog.io/artifactory";
  };
}
