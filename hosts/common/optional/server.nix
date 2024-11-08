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

    cloudflared
    zrok
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "qbittorrent-4.6.4" #TODO remove after update https://www.openwall.com/lists/oss-security/2024/10/30/4
  ];

  # Config Cloudflare tunnel
  services.cloudflared = {
    enable = true;

    tunnels = {
      "b933953f-8ded-497b-b133-5b55ab542b97" = {  # Jellyfin
        credentialsFile = "%home%/.cloudflared/cert.pem";
        ingress = {
          "jellyfin.frostyhill.top" = "http://localhost:8096";
        };
        default = "http_status:404";
      };

      "36f081f1-1fe8-4cbf-8715-be2640cc7149" = {  # Mindustry
        credentialsFile = "%home%/.cloudflared/cert.pem";
        ingress = {
          "mindustry.frostyhill.top" = "http://localhost:6364";
        };
        default = "http_status:404";
      };
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

  # Jellyfin intro skipper plugin fix
  nixpkgs.overlays = with pkgs; [
    (
      final: prev:
        {
          jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
            installPhase = ''
              runHook preInstall

              # this is the important line
              sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

              mkdir -p $out/share
              cp -a dist $out/share/jellyfin-web

              runHook postInstall
            '';
          });
        }
    )
  ];
}
