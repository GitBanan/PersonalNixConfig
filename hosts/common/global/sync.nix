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
          "Desktop" = { id = "W4K2KDX-IRNNTXF-XOUUWN7-ITWWP67-HFOAW4E-YBAMOY4-GWW4KEP-WZMVFQQ"; };
          "Vostro" = { id = "NRYRVGC-H3PVGKA-N7VH34E-QOX5MI6-D6WFJ2R-OZAHSPB-7BY3DQB-STZENQS"; };
          "Steamdeck" = { id = "5FLJ4J2-CEOYUU3-C67MPEB-LEKB56K-PPS2SEL-R33MXAX-5CD5QVI-WBTBKQE"; };
          "Nano" = { id = "K23SLN4-7MG6RXR-573XAYV-PRZPI4X-Q2DVASS-QGODSXU-MNHMJBI-2TRUVQO"; };
          "Hp260g9" = { id = "7PEIAWV-HAY2G3N-ROOZEHL-6RT2UC3-YFWRMOH-L465CGA-ZPTBSA3-X3S5LAF"; };
        };

        gui = {
          theme = "black";
        };

        options = {
          globalAnnounceEnabled = false;
          urAccepted = 3;
        };
      };
    };
  };

  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
