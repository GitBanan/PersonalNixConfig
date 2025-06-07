{
  pkgs,
  # config,
  ...
}: {
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    legcord # Discord

    # Wine
    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks
    protontricks
    protonup-qt

    lutris
    legendary-gl
    rare # GUI for legendary
    # heroic
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
}
