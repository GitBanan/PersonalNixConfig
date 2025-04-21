{
  pkgs,
  lib,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
    # extraUpFlags = ["--login-server https://tailscale.m7.rs"];
  };
  # networking.firewall.allowedUDPPorts = [41641]; # Facilitate firewall punching

  # environment.persistence = {
  #  "/persist".directories = ["/var/lib/tailscale"];
  # };

  systemd.services = {
    excludevpn-tailscaled = {
      description = "Exclude tailscale from Mullvad VPN";
      enable = false;
      wantedBy = [ "multi-user.target" ]; # Starts on boot
      after = [ "tailscaled.service" "mullvad-daemon.service"];
      wants = [ "tailscaled.service" "mullvad-daemon.service"];

      serviceConfig = {
        Type = "oneshot";
        User = "jee";
        # Restart = "always";
        # RestartSec=5;
        ExecStart = "${pkgs.mullvad}/bin/mullvad split-tunnel add $(${pkgs.toybox}/bin/pidof tailscaled)";
      };
    };
  };
}
