{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # All required packages for jellyfin
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg

    qbittorrent

    zrok
  ];

  # Start Zrok
  systemd.services = {
    zrok-jellyfin = {
      description = "Zrok service for Jellyfin";
      enable = true;
      after = [ "jellyfin.service" ];
      wantedBy = [ "multi-user.target" ]; # Starts on boot

      serviceConfig = {
        Type = "simple";
        User = "jee";
        Restart = "always";
        ExecStart = "${pkgs.zrok}/bin/zrok share reserved jellyfinjeeserveraccess --headless";
      };
    };
  };

  # Restart Jellyfin if it failes to launch (buggy - temporary fix)
  systemd.services = {
    restart-jellyfin = {
      description = "Restart Jellyfin";
      enable = true;
      after = [ "jellyfin.service" ];
      wantedBy = [ "multi-user.target" ]; # Starts on boot

      serviceConfig = {
        Type = "simple";
        User = "jee";
        Restart = "always";
        # ExecStart = "sleep 10; systemctl restart jellyfin.service";
      };

      script = ''
        sleep 10
        systemctl restart jellyfin.service
      '';
    };
  };

  services = {
    # Tailscale
    tailscale.enable = true;

    # Setup Arr stacks
    sonarr = {
      enable = true;
      user = "jee";
      openFirewall = true;
      dataDir = "/home/jee/.config/sonarr";
    };
    radarr = {
      enable = true;
      user = "jee";
      openFirewall = true;
      dataDir = "/home/jee/.config/radarr";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    # Setup Media server
    jellyfin = {
      enable = true;
      user = "jee";
      openFirewall = true;
      configDir = "/home/jee/.config/jellyfin";
      dataDir = "/home/jee/.local/share/jellyfin";
      cacheDir = "/home/jee/.cache/jellyfin";
    };

    # Setup jellyseerr
    jellyseerr = {
      enable = true;
      port = 5055;
      openFirewall = true;
    };
  };
}
