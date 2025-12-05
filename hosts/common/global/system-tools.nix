{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    fastfetch
    poppler-utils
    pciutils
    lshw
    lm_sensors

    xautomation

    python313Packages.qt-material # GUI for Tidal-DL

    ffmpeg
  ];
}
