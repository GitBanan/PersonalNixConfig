{
  pkgs,
  inputs,
  ...
}: {
  # Nix-Minecraft overlay
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services = {
    minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;

      servers.vanilla = {
        enable = true;
        jvmOpts = "-Xmx4G -Xms2G";

        # Specify the custom minecraft server package
        package = pkgs.vanillaServers.vanilla;
        # package = pkgs.minecraftServers.vanilla-server;

        # see here for more info: https://minecraft.gamepedia.com/Server.properties#server.properties
        serverProperties = {
          motd = "Jee's Vanilla Server";
          server-port = 25565;

          # level-seed = "10292992";
          online-mode = "false";
          # enforce-secure-profile = "false";
          # max-players = 5;

          gamemode = "survival";
          difficulty = "normal";
          pvp = "false";

          keepInventory = "true";
        };
      };

      servers.fabric = {
        enable = true;

        # Specify the custom minecraft server package
        package = pkgs.fabricServers.fabric-1_21_8;
        # package = pkgs.fabricServers.fabric-1_21_1.override { # Minecraft version "1_21_1" for "1.21.1"
        #   loaderVersion = "0.16.10"; # Specific fabric loader version
        # };

        # see here for more info: https://minecraft.gamepedia.com/Server.properties#server.properties
        serverProperties = {
          motd = "Jee's Modded Server";
          server-port = 26565;

          # level-seed = "10292992";
          online-mode = "false";
          # enforce-secure-profile = "false";
          # max-players = 5;

          gamemode = "survival";
          difficulty = "normal";
          pvp = "false";

          keepInventory = "true";
        };

        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" (
            builtins.attrValues {
              Fabric-API = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/e9QZFLr0/fabric-api-0.134.0%2B1.21.8.jar";
                sha512 = "85422c5b4f0cb07da912074034a84a5f704dddea557ad8d3123bacb1fca2aa69cc3ed3a1fea690d4209f400bbaae53b382e2a5909ee26dd34b134b144e740aae";
              };
              Skin-Overrides = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/GON0Fdk5/versions/EYz946Sq/skin_overrides-2.4.0-beta.2%2B1.21.8.jar";
                sha512 = "23aa8109f5dcff4fc030eb12e4b63e3038c107b95195fb61f43280ce4c55f9d1f50f6834c16b9f1a30f4b2540f4182c41f3cc27caede7d4e5a0b67ba1480ef25";
              };
            }
          );
        };
      };
    };
  };
}
