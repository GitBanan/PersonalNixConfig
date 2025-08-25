{
  description = "My NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05"; # Stable Nix Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; # Nix Packages (Default)

    hardware.url = "github:nixos/nixos-hardware/master"; # Hardware Specific Configurations
    systems.url = "github:nix-systems/default-linux"; # Supported systems for your flake packages, shell, etc.

    # impermanence.url = "github:nix-community/impermanence";
    # impermanence.url = "github:misterio77/impermanence";

    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # Nix Packages (Default)
    };

    nix = {
      url = "github:nixos/nix/2.22-maintenance";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nix-flatpak = {
      # url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nbfc-linux = {
      url = "github:nbfc-linux/nbfc-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    #tidal-ng = {
      #url = "https://gist.github.com/xaolanx/4c88d0cbc0dee90764bae767006103f8";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    #};
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          # config.allowBroken = true;
        }
    );
  in {
    inherit lib;
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    # Shell packages
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild switch --flake .#your-hostname'
    nixosConfigurations = {
      # Replace with your hostname
      desktop = lib.nixosSystem {
        modules = [
          ./hosts/desktop
        ];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      hp260g9 = lib.nixosSystem {
        modules = [
          ./hosts/hp260g9
        ];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      nano = lib.nixosSystem {
        modules = [
          ./hosts/nano
        ];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      nitro = lib.nixosSystem {
        modules = [
          ./hosts/nitro
        ];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      vostro = lib.nixosSystem {
        modules = [
          ./hosts/vostro
        ];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager switch --flake .#your-username@your-hostname'
    homeConfigurations = {
      # Replace with your username@hostname
      "jee@desktop" = lib.homeManagerConfiguration {
        modules = [ ./home/jee/desktop.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      "jee@hp260g9" = lib.homeManagerConfiguration {
        modules = [ ./home/jee/hp260g9.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      "jee@nano" = lib.homeManagerConfiguration {
        modules = [ ./home/jee/nano.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      "jee@nitro" = lib.homeManagerConfiguration {
        modules = [ ./home/jee/nitro.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      "jee@vostro" = lib.homeManagerConfiguration {
        modules = [ ./home/jee/vostro.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
