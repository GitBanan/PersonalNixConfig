{
  pkgs,
  config,
  ...
}: let
  hasIPv6Internet = false;
  StateDirectory = "dnscrypt-proxy";
in {
  networking = {
    # Enable networking, choose 1
    networkmanager = {
      enable = true; # Easier to use

      # dns = "systemd-resolved";
      dns = "none";
    };

    # These options are unnecessary when managing DNS ourselves
    useDHCP = false;
    dhcpcd.enable = false;

    # Let NextDNS manage DNS
    nameservers = [
      "127.0.0.1"
      "::1"
      # "45.90.28.0#${config.networking.hostName}--Resolved-$NEXTDNS_PROFILE_ID.dns.nextdns.io"
      # "2a07:a8c0::#${config.networking.hostName}--Resolved-$NEXTDNS_PROFILE_ID.dns.nextdns.io"
      # "45.90.30.0#${config.networking.hostName}--Resolved-$NEXTDNS_PROFILE_ID.dns.nextdns.io"
      # "2a07:a8c1::#${config.networking.hostName}--Resolved-$NEXTDNS_PROFILE_ID.dns.nextdns.io"
      "100.64.0.7"
    ];
  };

  systemd.services.nextdns.serviceConfig = {
    EnvironmentFile = config.sops.templates."nextdns-config".path;
  };

  services = {
    # Enable system-resolved
    resolved = {
      enable = false;
      # dnssec = "true";
      dnsovertls = "true";
      fallbackDns = [
        "100.64.0.7"
      ];
     };

    # See https://wiki.nixos.org/wiki/Encrypted_DNS
    dnscrypt-proxy = {
      enable = true;
      # See https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
      settings = {
        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3"; # See https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
          cache_file = "/var/lib/${StateDirectory}/public-resolvers.md";
        };

        # Use servers reachable over IPv6 -- Do not enable if you don't have IPv6 connectivity
        ipv6_servers = hasIPv6Internet;
        block_ipv6 = ! (hasIPv6Internet);

        require_dnssec = true;
        require_nolog = false;
        require_nofilter = true;

        # If you want, choose a specific set of servers that come from your sources.
        # Here it's from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        # If you don't specify any, dnscrypt-proxy will automatically rank servers
        # that match your criteria and choose the best one.
        server_names = [
          "mullvad-base-doh"
        ];
      };
    };

    dnsmasq = {
      enable = false;
      settings = {
        no-resolv = true;      # ❌ Don't use system DNS
        bogus-priv = true;      # 🔒 Block private IPs
        strict-order = true;      # 📐 Use servers in order
        server  = [
          "2a07:a8c1::"
          "45.90.30.0"
          "2a07:a8c0::"
          "45.90.28.0"
        ];
        add-cpe-id = config.sops.secrets.nextdns-profile-id.path;
      };
    };

    nextdns = {
      enable = false;
      arguments = [
        "-profile" "$NEXTDNS_PROFILE_ID"
        "-cache-size" "10MB"
        "-report-client-info"
      ];
    };
  };

  systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = StateDirectory;

  systemd.services.nextdns-activate = {
    enable = false;
    script = ''
      /run/current-system/sw/bin/nextdns activate
    '';
    after = [ "nextdns.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  environment.systemPackages = with pkgs; [
    dnscrypt-proxy
    # nextdns
    # dnsmasq
  ];
}
