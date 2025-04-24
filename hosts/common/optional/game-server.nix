{
  # pkgs,
  # config,
  ...
}: {
  services = {
    satisfactory-server = {
      enable = true;
      beta = "experimental";
    };
  };
}
