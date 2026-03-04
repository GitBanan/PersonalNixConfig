{
  # pkgs,
  config,
  ...
}: {
  services = {
    syncthing = {
      settings = {
        # Extra folders for backups
        folders = {
          "AppBackups" = {
            path = "${config.services.syncthing.dataDir}/AppBackups";
            devices = [ "Pixel7" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Contacts" = {
            path = "${config.services.syncthing.dataDir}/Contacts";
            devices = [ "Pixel7" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "DCIM" = {
            path = "${config.services.syncthing.dataDir}/DCIM";
            devices = [ "Pixel7" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "ProfileSync" = {
            path = "${config.services.syncthing.dataDir}/ProfileSync";
            devices = [ "Pixel7" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "SeedVault" = {
            path = "${config.services.syncthing.dataDir}/SeedVault";
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
