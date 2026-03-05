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
            devices = [ "Pixel" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Freetube" = {
            path = "${config.services.syncthing.dataDir}/Freetube";
            devices = [ "Pixel" ];
            versioning = {
              type = "trashcan";
              params = {
                cleanoutDays = "7";
              };
            };
          };
          "Productivity" = {
            path = "${config.services.syncthing.dataDir}/Productivity";
            devices = [ "Pixel" ];
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
