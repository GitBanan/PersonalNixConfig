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
    initialPassword = config.sops.secrets.default-user-password.path;
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
        "git"
        "networkmanager"
        "network"

        "docker"

        "libvirtd"
        "qemu-libvirtd"
        "disk"
        "kvm"
        "input"
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
