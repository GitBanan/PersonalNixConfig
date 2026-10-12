{
  # pkgs,
  # config,
  ...
}: {
  services.ludusavi = {
    settings = {
      roots = [
        {
          path = "~/.local/share/Steam";
          store = "steam";
        }
        {
          path = "~/.config/heroic";
          store = "heroic";
        }
        {
          path = "~/.local/share/lutris";
          store = "lutris";
        }
      ];
      customGames = [
        {
          name = "Barony";
          files = [
            "<base>/config"
            "<base>/savegames"
            "<base>/scores.dat"
            "<base>/scores_multiplayer.dat"
            "<home>/.barony/config"
            "<home>/.barony/savegames"
            "<home>/.barony/scores.dat"
            "<home>/.barony/scores_multiplayer.dat"
          ];
        }
      ];
      restore = {
        ignoredGames = [
          "Airships: Conquer the Skies"
          "Assetto Corsa"
          # "Barony"
          "Chivalry 2"
          "Don't Starve Together"
          "Lethal Company"
          "Mount & Blade: Warband"
          "Need for Speed: Most Wanted"
          "Space Engineers"
          "While True: learn()"
        ];
      };
    };
  };
}
