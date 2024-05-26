{
  networking = {
    # Enable networking, choose 1
    networkmanager = {
      enable = true; # Easier to use
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      insertNameservers = [ "https://dns.nextdns.io/ff152f" ];
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  services = {
    # Enable system-resolved
    resolved = {
      enable = true;
      extraConfig = ''
        DNS=45.90.28.0#ff152f.dns.nextdns.io
        DNS=2a07:a8c0::#ff152f.dns.nextdns.io
        DNS=45.90.30.0#ff152f.dns.nextdns.io
        DNS=2a07:a8c1::#ff152f.dns.nextdns.io
        DNSOverTLS=yes
      '';
     };
  };
}
