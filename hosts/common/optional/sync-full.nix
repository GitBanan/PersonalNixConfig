{
  # pkgs,
  config,
  ...
}: {
  services = {
    syncthing = {
      settings = {
        # Limited folders for main systems
        folders = {
          "FileShare" = {
            path = "${config.services.syncthing.dataDir}/FileShare";
            devices = [ "Pixel" "Desktop" "Vostro" "Nano" "Hp260g9" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "LinuxBackups" = {
            path = "${config.services.syncthing.dataDir}/LinuxBackups";
            devices = [ "Desktop" "Vostro" "Nano" "Hp260g9" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Productivity" = {
            path = "${config.services.syncthing.dataDir}/Productivity";
            devices = [ "Pixel" "Desktop" "Vostro" "Nano" "Hp260g9" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
        };

        # Extra folders for backups
        folders = {
          "AppBackups" = {
            path = "${config.services.syncthing.dataDir}/AppBackups";
            devices = [ "Pixel" "Desktop" "Nano" "Hp260g9" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Contacts" = {
            path = "${config.services.syncthing.dataDir}/Contacts";
            devices = [ "Pixel" "Desktop" "Nano" "Hp260g9" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "DCIM" = {
            path = "${config.services.syncthing.dataDir}/DCIM";
            devices = [ "Pixel" "Desktop" "Nano" "Hp260g9" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Ludusavi" = {
            path = "${config.services.syncthing.dataDir}/Ludusavi";
            devices = [ "Pixel" "Desktop" "Nano" "Hp260g9" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "ProfileSync" = {
            path = "${config.services.syncthing.dataDir}/ProfileSync";
            devices = [ "Pixel" "Desktop" "Nano" "Hp260g9" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "SeedVault" = {
            path = "${config.services.syncthing.dataDir}/SeedVault";
            devices = [ "Pixel" "Desktop" "Nano" "Hp260g9" ];
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
