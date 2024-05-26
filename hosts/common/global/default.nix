# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./audio.nix
      ./boot.nix
      # ./fish.nix
      ./gamemode.nix
      ./kde.nix
      ./locale.nix
      ./network.nix
      # ./nix-ld.nix
      ./nix.nix
      # ./optin-persistence.nix
      # ./podman.nix
      # ./sops.nix
      ./systemd-initrd.nix
      # ./tailscale.nix
      ./tools.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # Fix for qt6 plugins
  # environment.profileRelativeSessionVariables = {
    # QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
  # };

  hardware.enableRedistributableFirmware = true;
  # networking.domain = "m7.rs";

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];
}
