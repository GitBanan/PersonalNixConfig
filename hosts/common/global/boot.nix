{
  # pkgs,
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
}
