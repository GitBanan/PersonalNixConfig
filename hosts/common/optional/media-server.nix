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

    # qbittorrent

    # cloudflared
    # zrok
  ];

  nixpkgs.config.permittedInsecurePackages = [
    #"aspnetcore-runtime-wrapped-6.0.36"
    #"aspnetcore-runtime-6.0.36"
    #"dotnet-sdk-wrapped-6.0.428"
    #"dotnet-sdk-6.0.428"
  ];

  services = {
    # Setup Arr stack
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
    flaresolverr = {
      enable = true;
      openFirewall = true;
      package = pkgs.unstable.flaresolverr;
    };
    lidarr = {
      enable = true;
      user = "jee";
      openFirewall = true;
      dataDir = "/home/jee/.config/lidarr";
    };

    # Setup qbittorrent module
    qbittorrent = {
      enable = true;
      user = "jee";
      openFirewall = true;
      # profileDir = "/home/jee/.config/qbittorrent";
      webuiPort = 8080;

      serverConfig = {
        BitTorrent = {
          Session = {
            AlternativeGlobalDLSpeedLimit = 50;
            AlternativeGlobalUPSpeedLimit = 1;
            DefaultSavePath = "/home/jee/Downloads";
            DisableAutoTMMByDefault = false;
            DisableAutoTMMTriggers = {
              CategorySavePathChanged = false;
              DefaultSavePathChanged = false;
            };
            GlobalDLSpeedLimit = 10000;
            GlobalUPSpeedLimit = 10000;
            IgnoreLimitsOnLAN = true;
            QueueingSystemEnabled = false;
            TorrentContentLayout = "Subfolder";
          };
        };
        Core.AutoDeleteAddedTorrentFile = "Never";
        LegalNotice.Accepted = true;
        Preferences = {
          General.Locale = "en";
          WebUI = {
            Username = "admin";
            Password_PBKDF2 = "@ByteArray(qFEwkraPjUiRAGg/O+Mdzg==:tqu35bJc9Bx6YQ3WWrx9S+9dacnm/UQrJDWIpvC/+9klhaYlITKgheZbMxjQh4viiNmrsgTH3IwDle6QDKjiog==)";
          };
        };
        RSS = {
          AutoDownloader = {
            DownloadRepacks = true;
          };
        };
      };
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

  # Start Zrok Cloudflare on boot
  systemd.services = {
    zrok-jellyfin = {
      description = "Zrok service for Jellyfin";
      enable = false;
      wantedBy = [ "multi-user.target" ]; # Starts on boot
      after = [ "jellyfin.service" ];

      serviceConfig = {
        Type = "simple";
        User = "jee";
        Restart = "always";
        ExecStart = "${pkgs.zrok}/bin/zrok share reserved jellyfinjeeserveraccess --headless";
      };
    };
  };
}
