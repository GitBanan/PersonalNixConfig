# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  # outputs,
  # lib,
  # config,
  # pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # Import modules from other flakes (such as nixos-hardware):
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    ../common/global
    ../common/users/jee

    ../common/optional/nvidia.nix
    ../common/optional/nvidia-prime.nix

    ../common/optional/bluetooth.nix
    ../common/optional/editing-tools.nix
    ../common/optional/game-tools.nix
    ../common/optional/hardware-acceleration.nix
    ../common/optional/jellyfin-client.nix
    ../common/optional/libre.nix
    ../common/optional/media-tools.nix
    ../common/optional/mullvad.nix
    ../common/optional/openssh.nix
    ../common/optional/python.nix
    ../common/optional/sync.nix
  ];

  networking = {
    # Set your hostname
    hostName = "nitro";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # For running Epic Games store
  # hardware.opengl.driSupport32Bit = true;

  programs = {
    # Enable optional KDE features
    kdeconnect.enable = true;

    firefox.enable = true;
  };

  # environment.systemPackages = with pkgs; [];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
