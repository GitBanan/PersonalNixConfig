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
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Contacts" = {
            path = "${config.services.syncthing.dataDir}/Contacts";
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "DCIM" = {
            path = "${config.services.syncthing.dataDir}/DCIM";
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "ProfileSync" = {
            path = "${config.services.syncthing.dataDir}/ProfileSync";
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "SeedVault" = {
            path = "${config.services.syncthing.dataDir}/SeedVault";
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
