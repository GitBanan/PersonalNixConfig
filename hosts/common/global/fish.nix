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
      gacp = "git add .; and git commit -am $argv; and git push";
    };
  };
}
