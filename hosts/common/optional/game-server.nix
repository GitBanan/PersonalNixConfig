{
  pkgs,
  inputs,
  ...
}: {
  # Nix-Minecraft overlay
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services = {
    satisfactory-server = {
      enable = true;
      beta = "experimental";
    };

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
          motd = "Jee's Vanilla server";
          server-port = 25565;

          # level-seed = "10292992";
          online-mode = "false";
          # enforce-secure-profile = "false";
          # max-players = 5;

          gamemode = "survival";
          pvp = "false";
        };
      };

      servers.fabric = {
        enable = false;

        # Specify the custom minecraft server package
        package = pkgs.fabricServers.fabric;
        # package = pkgs.fabricServers.fabric-1_21_1.override { # Minecraft version "1_21_1" for "1.21.1"
        #   loaderVersion = "0.16.10"; # Specific fabric loader version
        # };

        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" (
            builtins.attrValues {
              Fabric-API = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/9YVrKY0Z/fabric-api-0.115.0%2B1.21.1.jar";
                sha512 = "e5f3c3431b96b281300dd118ee523379ff6a774c0e864eab8d159af32e5425c915f8664b1";
              };
              Backpacks = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/MGcd6kTf/versions/Ci0F49X1/1.2.1-backpacks_mod-1.21.2-1.21.3.jar";
                sha512 = "6efcff5ded172d469ddf2bb16441b6c8de5337cc623b6cb579e975cf187af0b79291";
              };
            }
          );
        };
      };
    };
  };
}
