{
  # pkgs,
  # config,
  ...
}: {
  services.ludusavi = {
    settings = {
      customGames = [
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
      ];
    };
  };
}
