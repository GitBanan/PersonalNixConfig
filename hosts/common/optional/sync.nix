{
  # pkgs,
  # config,
  ...
}: {
  services = {
    # Syncthing service
    syncthing = {
      enable = true;
      user = "jee";
      dataDir = "/home/jee/Sync";    # Default folder for new synced folders
      configDir = "/home/jee/.config/syncthing";   # Folder for Syncthing's settings and keys
      guiAddress = "127.0.0.1:8384";
      openDefaultPorts = true;

      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "Pixel7" = { id = "BEA64PF-MADNI3F-4ONKTOA-FMHRRAA-7IBPNBB-FGUYJUL-VSS7ON7-B62WYQC"; };
        };
        folders = {
          "AppBackups" = {
            path = "/home/jee/Sync/AppBackups";
            devices = [ "Pixel7" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Contacts" = {
            path = "/home/jee/Sync/Contacts";
            devices = [ "Pixel7" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "DCIM" = {
            path = "/home/jee/Sync/DCIM";
            devices = [ "Pixel7" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "FileShare" = {
            path = "/home/jee/Sync/FileShare";
            devices = [ "Pixel7" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "SeedVault" = {
            path = "/home/jee/Sync/SeedVault";
            devices = [ "Pixel7" ];
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
}
