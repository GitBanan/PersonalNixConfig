{
  pkgs,
  inputs,
  ...
}: {
  services = {
    satisfactory-server = {
      enable = true;
      beta = "experimental";
    };
  };
};
