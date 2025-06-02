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
    tidal-dl
    tidal-hifi

    freetube
    grayjay
    yt-dlp
  ];
}
