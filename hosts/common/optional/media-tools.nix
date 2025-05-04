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
    unstable.freetube
    unstable.grayjay
    yt-dlp
  ];
}
