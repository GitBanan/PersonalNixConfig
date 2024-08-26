{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vivaldi

    easyeffects
    qalculate-qt
    haruna # Video player
    spotube
    freetube

    vscodium
    libxml2 # Format XML
    eclipses.eclipse-jee

    lzip # Unzip
    pciutils
    lshw
    xautomation
    fastfetch
    android-tools # ADB
    lm_sensors
    krita
    poppler_utils
    unrar
    p7zip
  ];
}
