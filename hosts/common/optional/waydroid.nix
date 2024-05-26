{
  pkgs,
  # config,
  ...
}: {
  virtualisation.waydroid.enable = true;

  environment.systemPackages = with pkgs; [
    scrcpy # Input
    wl-clipboard # Share clipboard
  ];
}
