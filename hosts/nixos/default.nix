# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  # outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # Import modules from other flakes (such as nixos-hardware):
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    ../common/global
    ../common/users/jee

    ../common/optional/vm.nix
    # ../common/optional/passthrough.nix
  ];

  networking = {
    # Set your hostname
    hostName = "nixos";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  programs = {
    # Enable optional KDE features
    kdeconnect.enable = true;
    firefox.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kate
    zrok
  ];

  # Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    jee = {
      # You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "password";
      isNormalUser = true;
      description = "Jee";

      # Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "networkmanager" "wheel" "libvirtd" ];

      # Keep user service running after log out
      linger = true;

      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];

      packages = with pkgs; [
        armcord # Better options?
        haruna
        qbittorrent # Need module
        vivaldi
        vscodium
        freetube
        easyeffects
        protonvpn-gui
        libxml2 # Format XML
        eclipses.eclipse-jee
        qalculate-qt
        xautomation
        neofetch
        python3
        python311Packages.inquirerpy
        python312Packages.inquirerpy
        scrcpy
        wl-clipboard
        android-tools
        lzip
        pciutils

        # Additional packages for jellyfin
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
        jellyfin-media-player

        # Libreoffice
        libreoffice-qt-fresh
        hunspell
        hunspellDicts.uk_UA
        hunspellDicts.th_TH

        # Wine
        wineWowPackages.stable
        wineWowPackages.waylandFull
        winetricks
        protontricks
        protonup-qt
      ];
    };
  };

  # Install Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # extraCompatPackages = with pkgs; [
    #   proton-ge-bin # Glorious Egg Proton
    # ];
  };

  # Enable Hardware Transcoding VAAPI for jellyfin
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      # vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
    ];
  };

  services = {
    # Enable system-resolved
    resolved = {
      enable = true;
      extraConfig = ''
        DNS=45.90.28.0#ff152f.dns.nextdns.io
        DNS=2a07:a8c0::#ff152f.dns.nextdns.io
        DNS=45.90.30.0#ff152f.dns.nextdns.io
        DNS=2a07:a8c1::#ff152f.dns.nextdns.io
        DNSOverTLS=yes
      '';
     };

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
          "Aegis" = {
            path = "/home/jee/Sync/Aegis";
            devices = [ "Pixel7" ];
            versioning = {
              type = "trashcan";
              params.cleanoutDays = "7";
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

    # Setup Arr stacks
    sonarr = {
      enable = true;
      user = "jee";
      openFirewall = true;
      dataDir = "/home/jee/.config/sonarr";
    };
    radarr = {
      enable = true;
      user = "jee";
      openFirewall = true;
      dataDir = "/home/jee/.config/radarr";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    # Setup Media server
    jellyfin = {
      enable = true;
      user = "jee";
      openFirewall = true;
      configDir = "/home/jee/.config/jellyfin";
      dataDir = "/home/jee/.local/share/jellyfin";
      cacheDir = "/home/jee/.cache/jellyfin";
    };

    # Setup jellyseerr
    jellyseerr = {
      enable = true;
      port = 5055;
      openFirewall = true;
    };

    # This setups a SSH server. Very important if you're setting up a headless system.
    # Feel free to remove if you don't need it.
    openssh = {
      enable = true;
      settings = {
        # Forbid root login through SSH.
        PermitRootLogin = "no";
        # Use keys only. Remove if you want to SSH using password (not recommended)
        PasswordAuthentication = false;
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
