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
      settings.gui.user = "SyncthingUser";
      # settings.gui.password = "temppassword";
      guiPasswordFile = config.sops.secrets."syncthing-password".path;

      overrideDevices = false;
      overrideFolders = true;
      settings = {
        devices = {
          "Pixel" = { id = "BEA64PF-MADNI3F-4ONKTOA-FMHRRAA-7IBPNBB-FGUYJUL-VSS7ON7-B62WYQC"; };
        };

        gui = {
          theme = "black";
        };
      };
    };
  };

  # port 8384  is the default port to allow access from the network.
  networking.firewall.allowedTCPPorts = [ 8384 ];
}
