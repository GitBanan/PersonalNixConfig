{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs.unstable; [
    esphome
    esptool

    # android-tools # ADB
  ];
}
