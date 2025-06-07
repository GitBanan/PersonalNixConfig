{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.common.minecraft;
  # Target minecraft version
  mcVersion = "1.20.1";
  # Version of toolchain (fabric in this case)
  fabricVersion = "0.15.7";
  # Format minecraft version, replacing . with _
  serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
in {
  # Import nix-minecraft to provide path to mod toolchain packages
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  options.common.minecraft = {
    enable = mkEnableOption "Enable Minecraft Server";
  };

  config = mkIf cfg.enable {
    services = {
      # Server configuration module options
      minecraft-servers = {
        enable = true;
        eula = true; # accepting EULA is required for server to run
        # Rename and clear out /srv/minecraft to setup new server
        servers.server-name = {
          enable = true;
          package = pkgs.fabricServers.${serverVersion}.override {loaderVersion = fabricVersion;};
          serverProperties = {
            # Adjust server properties to fit needs
            server-port = 25565;
            gamemode = "peaceful";
            motd = "NixOS Pokemon"; # Server name
            max-players = 2;
            level-seed = "10292758"; # Seed for level generation
          };
          symlinks = {
            # List all mods to be installed
            mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
              # Example values returned by nix run command
              #FabricApi = pkgs.fetchurl {
                #url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/YG53rBmj/fabric-api-0.92.0%2B1.20.1.jar";
                #sha512 = "53ce4cb2bb5579cef37154c928837731f3ae0a3821dd2fb4c4401d22d411f8605855e8854a03e65ea4f949dfa0e500ac1661a2e69219883770c6099b0b28e4fa";
              #};
              #Pokemon = pkgs.fetchurl {
                #url = "https://cdn.modrinth.com/data/MdwFAVRL/versions/uWAkNUxZ/Cobblemon-fabric-1.4.1%2B1.20.1.jar";
                #sha512 = "6955c8ad187d727cbfc51761312258600c5480878983cfe710623070c90eb437e419c140ff3c77e5066164876ecfe1e31b87f58f5ef175f0758efcff246b85a8";
              #};
            });
          };
        };
      };
    };
  };
}
