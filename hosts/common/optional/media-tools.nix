{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs.unstable; [
    haruna # Video player
    vlc

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
