{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../secrets.yaml;

    age = {
      keyFile = "/home/jee/.config/sops/age/keys.txt";
    };

    # This is the actual specification of the secrets.
    secrets = {
      default-user-password = {
        neededForUsers = true;
      };

      syncthing-password = {
        owner = "jee";
      };

      mqtt-password = {};

      nextdns-profile-id = {};
    };

    templates = {
      "nextdns-config".content = ''NEXTDNS_PROFILE_ID=${config.sops.placeholder."nextdns-profile-id"}'';

      # "syncthing-nano".content = ''${config.sops.placeholder."syncthing-nano"}'';
    };
  };

  environment.systemPackages = with pkgs; [
    sops
  ];
}
