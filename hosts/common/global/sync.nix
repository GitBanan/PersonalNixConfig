{
  # pkgs,
  config,
  ...
}: {
  services = {
    # Syncthing service
    syncthing = {
      enable = true;
      user = "jee";
      # dataDir = "/home/jee/Sync";    # Default folder for new synced folders, defined in hosts/../default.nix
      configDir = "/home/jee/.config/syncthing";   # Folder for Syncthing's settings and keys
      guiAddress = "0.0.0.0:8384";
      openDefaultPorts = true;
      # Optional: GUI credentials (can be set in the browser instead)
      # settings.gui.user = "SyncthingUser";
      # settings.gui.password = "temppassword";
      # guiPasswordFile = config.sops.secrets.syncthing-password.path;

      overrideDevices = false;
      overrideFolders = true;
      settings = {
        # Limited folders for main systems
        folders = {
          "FileShare" = {
            path = "${config.services.syncthing.dataDir}/FileShare";
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Freetube" = {
            path = "${config.services.syncthing.dataDir}/Freetube";
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Productivity" = {
            path = "${config.services.syncthing.dataDir}/Productivity";
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
        };
      };
    };
  };

  # port 8384  is the default port to allow access from the network.
  networking.firewall.allowedTCPPorts = [ 8384 ];
}
