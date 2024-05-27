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
    jellyfin-media-player

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

  services = {
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
