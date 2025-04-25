{
  pkgs,
  # config,
  ...
}: {
  services = {
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn; #GUI
    };
  };

  systemd.services = {
    excludevpn-tailscaled = {
      description = "Exclude tailscale from Mullvad VPN";
      enable = false;
      wantedBy = [ "multi-user.target" ]; # Starts on boot
      after = [ "tailscaled.service" "mullvad-daemon.service"];
      wants = [ "tailscaled.service" "mullvad-daemon.service"];

      serviceConfig = {
        Type = "simple";
        User = "jee";
        Restart = "always";
        RestartSec=10;
        ExecStart = "${pkgs.mullvad}/bin/mullvad split-tunnel add $(pidof tailscaled)";
      };
    };
  };
}
