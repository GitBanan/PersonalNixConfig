{
  # User friendly interactive shell
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };

    shellInit = ''
      # Disable greeting
      set fish_greeting

      # git commit and push function
      function gacp
        git add .
        git commit -m "$argv"
        git push
      end
    '';
  };
}
