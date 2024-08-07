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

    vscodium
    libxml2 # Format XML
    eclipses.eclipse-jee

    lzip # Unzip
    pciutils
    xautomation
    fastfetch
    android-tools # ADB
    lm_sensors
    krita
  ];
}
