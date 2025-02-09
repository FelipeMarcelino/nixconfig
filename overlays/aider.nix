(final: prev: {
  # Override the aider-chat package
  aider-chat = prev.aider-chat.overrideAttrs (oldAttrs: rec {
    version = "0.72.3";
    # Override the src using the new hash from the PR.
    src = prev.fetchFromGitHub {
      owner = "Aider-AI";
      repo = "aider";
      tag = "v${version}";
      hash = "sha256-aOdLaH/95i2/h86rH578Z9iAtQSf7rI0PvnZQEx4Yjs=";
    };
  });
})
