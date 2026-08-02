{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs.unstable; [
    haruna # Video player
    vlc

    jellyfin-desktop  # QT_QPA_PLATFORM=xcb
    jftui

    # spotube
    # nuclear
    tidal-hifi
    # high-tide

    # tidal-dl
    # streamrip
    picard

    # freetube
    # grayjay
    yt-dlp
  ];
}
