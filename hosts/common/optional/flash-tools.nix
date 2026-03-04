{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    esphome
    esptool

    # android-tools # ADB
  ];
}
