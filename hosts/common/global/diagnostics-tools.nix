{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    fastfetch

    htop
    speedtest-cli

    busybox
    pciutils
    lshw
    lm_sensors
    dig
    nix-output-monitor # Monitor build logs during Nix compile
  ];
}
