{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs.unstable; [
    esphome
    esptool

    arduino-ide

    # android-tools # ADB
  ];
}
