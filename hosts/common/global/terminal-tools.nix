{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    fastfetch

    vim
  ];
}
