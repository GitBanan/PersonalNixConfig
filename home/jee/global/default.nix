{
  # inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      # inputs.impermanence.nixosModules.home-manager.impermanence
      # ../features/cli
      # ../features/nvim
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName  = "GitBanan";
      userEmail = "dumping.runner332@addy.io";
    };
  };

  home = {
    username = lib.mkDefault "jee";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      FLAKE = "$HOME/Nix/PersonalNixConfig/";
    };

    enableNixpkgsReleaseCheck = false;

    # persistence = {
    #   "/persist/home/jee" = {
    #     defaultDirectoryMethod = "symlink";
    #     directories = [
    #       "MainDirectory"
    #       "Sync"
    #       "VM"
    #       "Documents"
    #       "Downloads"
    #       "Pictures"
    #       "Music"
    #       "Videos"
    #       ".local/bin"
    #       ".local/share/nix" # trusted settings and repl history
    #     ];
    #     allowOther = true;
    #   };
    # };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = lib.mkDefault "23.11";
  };
}
