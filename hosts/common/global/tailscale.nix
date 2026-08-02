{
  pkgs,
  lib,
  ...
}: {
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    useRoutingFeatures = lib.mkDefault "client";
    # extraUpFlags = ["--login-server https://tailscale.m7.rs"];
  };
  # networking.firewall.allowedUDPPorts = [41641]; # Facilitate firewall punching

  # environment.persistence = {
  #  "/persist".directories = ["/var/lib/tailscale"];
  # };

  # Fixing tailsacle shutdown delays (Adding iwd.service to existing), review later to see if fixed upstream TODO
  # systemd.services.tailscaled.after = [ "iwd.service" "network-pre.target" "NetworkManager.service" "systemd-resolved.service" ];
}
