{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    fastfetch
    poppler_utils
    pciutils
    lshw
    xautomation
    lm_sensors
  ];
}
