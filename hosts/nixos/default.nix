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
  ];

  # nixpkgs = {
    # You can add overlays here
    # overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # outputs.overlays.additions
      # outputs.overlays.modifications
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    # ];
    # Configure your nixpkgs instance
    # config = {
      # Disable if you don't want unfree packages
      # allowUnfree = true;
    # };
  # };

  # Using UEFI bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 20; # Maximum generations
      efi.canTouchEfiVariables = true;
      timeout = 1; # Time to confirm generation
    };

    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelParams = [ "intel_iommu=on" "iommu=pt" "vfio-pci.ids=1002:73df,1002:ab28" ];
    # kernelModules = [ "kvm-intel" ];
    # initrd.availableKernelModules = [ "amdgpu" "vfio-pci" ];
    # initrd.preDeviceCommands = ''
    #   DEVS="00003:00.0 00003:00.1"
    #   for DEV in $DEVS; do
    #     echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    #   done
    #   modprobe -i vfio-pci
    # '';
  };

  # Setup VM
  virtualisation = {
    waydroid.enable = true;
    # virtualbox.host.enable = true; # For VirtualBox

    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        runAsRoot = false;
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };

  # Setup hypervisor for VM
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = ["qemu:///system"];
  #     uris = ["qemu:///system"];
  #   };
  # };
  # users.extraGroups.vboxusers.members = [ "jee" ]; # For VirtualBox

  networking = {
    # Set your hostname
    hostName = "nixos";

    # Enable networking, choose 1
    networkmanager = {
      enable = true; # Easier to use
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      insertNameservers = [ "https://dns.nextdns.io/ff152f" ];
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true; # Enable Plasma 6

  services = {
    xserver = {
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };

      # Enable the X11 windowing system.
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
    # Enable the X11 windowing system.
    displayManager.sddm = {
      enable = true;
      wayland.enable = true; # Enable Plasma 6
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # Enable auto update
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "weekly";
  };

  programs = {
  # Enable optional KDE features
    kdeconnect.enable = true;
    firefox.enable = true;

    # Enable home-manager and git
    # home-manager.enable = true;
    git.enable = true;

    virt-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kate
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
        zrok
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
      vaapiIntel
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
