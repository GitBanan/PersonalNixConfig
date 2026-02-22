{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    python3
    pipx

    python313Packages.qt-material # GUI for Tidal-DL

    unstable.python313Packages.tidalapi
  ];
}
