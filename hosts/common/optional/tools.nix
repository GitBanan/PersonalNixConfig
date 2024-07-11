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
    # Create symlink to script eg:
    # ln -s /nix/store/7g12vr81p0lc7f7q3ag8ww0z92vxvpqj-mpv-mpris-1.1/share/mpv/scripts/mpris.so /home/jee/.local/share/jellyfinmediaplayer/scripts/

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
