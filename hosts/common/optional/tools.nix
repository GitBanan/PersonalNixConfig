{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    easyeffects
    qalculate-qt
    haruna # Video player
    vlc
    # spotube
    nuclear
    freetube
    # mullvad-vpn

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
    # rustdesk-flutter
  ];
}
