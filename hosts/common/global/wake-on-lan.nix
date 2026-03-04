{
  pkgs,
  # config,
  # inputs,
  ...
}: {
  networking = {
    # Wake on Lan Setup
    interfaces = {
      enp2s0 = {
        wakeOnLan.enable = true;
      };

      eno2 = {
        wakeOnLan.enable = true;
      };
    };
    firewall = {
      allowedUDPPorts = [ 9 ];
    };
  };

  environment.systemPackages = with pkgs; [
    wakeonlan
  ];
}
