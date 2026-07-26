{
  # User friendly interactive shell
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };

    shellAliases = {
      gacp = "git add .; and git commit -m $argv[1]; and git push;";
    };
  };
}
