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

        # Media servers
        {
          name = "Home Assistant";
          files = [
            "/var/lib/containers/storage/volumes/home-assistant/_data/backups"
          ];
        }
        {
          name = "Frigate";
          files = [
            "/var/lib/containers/storage/volumes/frigate/_data/config.yaml"
          ];
        }
      ];
    };
  };
}
