{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vim

    easyeffects
    android-tools # ADB
    qalculate-qt
    rustdesk-flutter

    libxml2 # Format XML
    eclipses.eclipse-jee

    lzip # Unzip
    unrar
    p7zip

    vscodium
    krita

    nixfmt
  ];
}
