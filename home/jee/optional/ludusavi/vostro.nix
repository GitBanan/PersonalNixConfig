{
  # pkgs,
  # config,
  ...
}: {
  services.ludusavi = {
    settings = {
      backup = {
        ignoredGames = [
          "Barotrauma"
          "Buckshot Roulette"
          "Stick Fight: The Game"
          "Totally Accurate Battlegrounds"
        ];
      };
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
          path = "/mnt/980_Pro/Steam";
          store = "steam";
        }
        {
          path = "~/.local/share/lutris";
          store = "lutris";
        }
      ];
      customGames = [
        {
          name = "Need for Speed: Most Wanted";
          files = [
            "<winDocuments>/NFS Most Wanted/<storeUserId>"
            "/home/jee/Games/Lutris/need-for-speed-most-wanted/Need For Speed Most Wanted Black Edition/SAVE"
          ];
          registry = [ "HKEY_LOCAL_MACHINE/SOFTWARE/WOW6432Node/EA Games/Need for Speed Most Wanted" ];
        }
        {
          name = "Mount & Blade: Warband";
          files = [
            "<home>/.mbwarband"
            "<home>/.mbwarband/Savegames"
            "<home>/Library/Application Support/MBWarband"
            "<home>/Library/Application Support/MBWarband/Savegames"
            "<winDocuments>/Mount&Blade Warband"
            "<winDocuments>/Mount&Blade Warband Savegames"
          ];
          installDir = [ "MountBlade Warband" ];
        }
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
        {
          name = "Chivalry 2";
          files = [
            "<winLocalAppData>/Chivalry 2/Saved/Config/WinGDK"
            "<winLocalAppData>/Chivalry 2/Saved/Config/WindowsNoEditor"
            "<winLocalAppData>/Packages/TripwireInteractiveLLC.Chivalry2_237dqjpew1r3m/SystemAppData/wgs"
          ];
        }
        {
          name = "While True: learn()";
          files = [
            "<base>/Saves"
            "<root>/userdata/<storeUserId>/619150/remote"
          ];
          registry = [ "HKEY_CURRENT_USER/Software/Luden.io/while True: learn()" ];
          installDir = [ "wtl" ];
        }
      ];
    };
  };
}
