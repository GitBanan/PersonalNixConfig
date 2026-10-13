{
  # pkgs,
  # config,
  ...
}: {
  services.ludusavi = {
    settings = {
      customGames = [
        # Game servers
        {
          name = "Minecraft Server";
          files = [
            "/srv/minecraft/vanilla/world"
            "/srv/minecraft/fabric/world"
          ];
        }
        {
          name = "Satisfactory Server";
          files = [
            "/var/lib/satisfactory/.config/Epic/FactoryGame/Saved/SaveGames"
          ];
        }

        # Media servers
        {
          name = "Sonarr";
          files = [
            "/var/lib/sonarr/Backups"
          ];
        }
        {
          name = "Radarr";
          files = [
            "/var/lib/radarr/Backups"
          ];
        }
        {
          name = "Prowlarr";
          files = [
            "/var/lib/prowlarr/Backups"
          ];
        }
        {
          name = "Bazarr";
          files = [
            "/var/lib/bazarr/Backups"
          ];
        }
        {
          name = "Lidarr";
          files = [
            "/var/lib/lidarr/Backups"
          ];
        }
        {
          name = "qBittorrent";
          files = [
            "/var/lib/qBittorrent/qBittorrent/config"
            "/var/lib/qBittorrent/qBittorrent/data/BT_backup"
            "/var/lib/qBittorrent/qBittorrent/data/rss"
          ];
        }
        {
          name = "Jellyfin";
          files = [
            "/home/jee/.local/share/jellyfin/data/backups"
          ];
        }
        {
          name = "Seerr";
          files = [
            "/var/lib/seerr/settings.json"
            "/var/lib/seerr/db"
          ];
        }
      ];
    };
  };
}
