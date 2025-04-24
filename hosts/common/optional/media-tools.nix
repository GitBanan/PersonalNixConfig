{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    haruna # Video player
    vlc
    # spotube
    nuclear
    freetube
    unstable.grayjay
    yt-dlp
  ];
}
