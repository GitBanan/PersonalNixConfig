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
          "Freetube" = {
            path = "${config.services.syncthing.dataDir}/Freetube";
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
      };
    };
  };
}
