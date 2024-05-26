{
  pkgs,
  config,
  # lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # users.mutableUsers = false;
  users.users.jee = {
    # You can set an initial password for your user.
    # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
    # Be sure to change it (using passwd) after rebooting!
    initialPassword = "password";
    isNormalUser = true;
    description = "Jee";
    # shell = pkgs.fish;

    # Keep user service running after log out
    linger = true;

    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "networkmanager"
        "network"
        "git"
        "libvirtd"
        "qemu-libvirtd"
        "disk"
        "docker"
      ];

    # openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/jee/ssh.pub);
    # hashedPasswordFile = config.sops.secrets.jee-password.path;
    packages = [pkgs.home-manager];
  };

  # sops.secrets.jee-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };

  home-manager.users.jee = import ../../../../home/jee/${config.networking.hostName}.nix;

  # security.pam.services = {
  #   swaylock = {};
  # };
}
