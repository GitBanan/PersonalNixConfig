{
  pkgs,
  config,
  ...
}: {
  networking = {
    # Enable networking, choose 1
    networkmanager = {
      enable = true; # Easier to use

      # dns = "systemd-resolved";
      # dns = "none";

      # insertNameservers = [ "
        # 45.90.28.0#${config.networking.hostName}--Resolved-${NEXTDNS_PROFILE_ID}.dns.nextdns.io
        # 2a07:a8c0::#${config.networking.hostName}--Resolved-${NEXTDNS_PROFILE_ID}.dns.nextdns.io
        # 45.90.30.0#${config.networking.hostName}--Resolved-${NEXTDNS_PROFILE_ID}.dns.nextdns.io
        # 2a07:a8c1::#${config.networking.hostName}--Resolved-${NEXTDNS_PROFILE_ID}.dns.nextdns.io
      # " ];
    };

    # Let NextDNS manage DNS
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
  };

  services = {
    # Enable system-resolved
    resolved = {
      enable = false;
     };

    nextdns = {
      enable = true;
      arguments = [
        "-profile" "$NEXTDNS_PROFILE_ID"
        "-cache-size" "10MB"
        "-report-client-info"
      ];
    };
  };

  systemd.services.nextdns.serviceConfig = {
    EnvironmentFile = config.sops.templates."nextdns-config".path;
  };

  systemd.services.nextdns-activate = {
    script = ''
      /run/current-system/sw/bin/nextdns activate
    '';
    after = [ "nextdns.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  environment.systemPackages = with pkgs; [ nextdns ];
}
