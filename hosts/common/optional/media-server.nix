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
    qbittorrent-nox

    cloudflared
    zrok
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
    };
    lidarr = {
      enable = true;
      user = "jee";
      openFirewall = true;
      dataDir = "/home/jee/.config/lidarr";
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
      enable = true;
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

  # Jellyfin intro skipper plugin fix
  #nixpkgs.overlays = with pkgs; [
  #  (
  #    final: prev:
  #      {
  #        jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
  #          installPhase = ''
  #            runHook preInstall

              # this is the important line
  #            sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

  #           mkdir -p $out/share
  #            cp -a dist $out/share/jellyfin-web

  #            runHook postInstall
  #          '';
  #        });
  #      }
  #  )
  #];
}
