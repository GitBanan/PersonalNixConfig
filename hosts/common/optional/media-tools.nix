{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    haruna # Video player
    vlc

    # spotube
    # nuclear
    tidal-dl
    tidal-hifi

    unstable.freetube
    # unstable.grayjay
    yt-dlp
  ];
}
