{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # imports = [./packages.nix];

  users.mutableUsers = false;
  users.users.jee = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "network"
        "git"
        "libvirtd"
        # "minecraft"
        # "wireshark"
        # "i2c"
        # "mysql"
        # "docker"
        # "podman"
        # "deluge"
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
