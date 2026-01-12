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
    # tidal-dl
    tidal-hifi
    # high-tide

    # freetube
    grayjay
    yt-dlp
  ];
}
