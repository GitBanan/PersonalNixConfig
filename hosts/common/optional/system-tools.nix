{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    xautomation
    ffmpeg
    easyeffects
    qalculate-qt
    rustdesk-flutter
  ];
}
