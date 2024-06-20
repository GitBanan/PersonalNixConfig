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

    jellyfin-media-player
    mpvScripts.mpris # Media keys support for jellyfin

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
