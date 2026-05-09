{
  pkgs,
  # config,
  ...
}: {
  # Using UEFI bootloader
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 20; # Maximum generations
    efi.canTouchEfiVariables = true;
    timeout = 1; # Time to confirm generation
  };

  # Disable emergency mode when mount fails
  systemd.enableEmergencyMode = false;

  # Copyfail patch TODO Revert when fixed in release
  boot.kernelPackages = pkgs.linuxPackages_6_18;
}
