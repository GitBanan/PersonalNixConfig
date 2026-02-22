{
  pkgs,
  # config,
  ...
}: {
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs.unstable; [
    legcord # Discord

    # Wine
    wine64
    wineWow64Packages.stable
    wineWow64Packages.waylandFull
    winetricks
    protontricks
    # protonup-qt
    protonplus

    lutris
    legendary-gl
    # rare # GUI for legendary
    heroic
    mangohud

    prismlauncher # Minecraft
  ];

  # Install Steam
  programs.steam = {
    enable = true;
    extest.enable = true; # Steam Input on Wayland
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extraCompatPackages = with pkgs; [
      proton-ge-bin # Glorious Egg Proton
    ];
  };

  # Lossless Scaling's frame generation
  # services.lsfg-vk = {
    # enable = false;
    # ui.enable = true; # installs gui for configuring lsfg-vk
  # };
}
