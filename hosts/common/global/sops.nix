{
  inputs,
  # config,
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
      default-user-password = {};
    };
  };
}
