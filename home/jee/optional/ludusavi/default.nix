{
  # pkgs,
  config,
  ...
}: {
  services.ludusavi = {
    enable = true;
    frequency = "daily";
    settings = {
      theme = "dark";
      release.check = false;
      backup = {
        filter = {
          excludeStoreScreenshots = true;
          cloud = {
            exclude = true;
            epic = false;
            gog = false;
            origin = false;
            steam = true;
            uplay = false;
          };
        };
        retention = {
          full = 1;
          differential = 5;
        };
        format = {
          chosen = "zip";
          zip.compression = "zstd";
          compression = {
            deflate.level = 6;
            bzip2.level = 6;
            zstd.level = 10;
          };
        };
        ignoredGames = [
          "Barotrauma"
          "Buckshot Roulette"
          "Stick Fight: The Game"
          "Totally Accurate Battlegrounds"
        ];
      };
      language = "en-US";
      restore = {
        path = "${config.services.ludusavi.settings.backup.path}";
      };
    };
  };
}
