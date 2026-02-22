{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    poppler-utils
    pciutils
    lshw
    lm_sensors

    xautomation

    ffmpeg

    localsend
  ];
}
