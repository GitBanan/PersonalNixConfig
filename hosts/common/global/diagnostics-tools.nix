{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    fastfetch
    busybox
    pciutils
    lshw
    lm_sensors
    dig
    nix-output-monitor # Monitor build logs during Nix compile
    speedtest-cli
  ];
}
