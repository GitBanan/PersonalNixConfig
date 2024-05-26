{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vivaldi
    haruna # Video player
    easyeffects
    qalculate-qt

    vscodium
    libxml2 # Format XML
    eclipses.eclipse-jee

    lzip # Unzip
    pciutils
    xautomation
    neofetch
    android-tools # ADB
  ];
}
