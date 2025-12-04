{
  inputs,
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # jellyfin-media-player
    # nur.repos.mio.jellyfin-media-player
    mpvScripts.mpris # Media keys support for jellyfin
    # Create symlink to script eg:
    # ln -s /nix/store/7g12vr81p0lc7f7q3ag8ww0z92vxvpqj-mpv-mpris-1.1/share/mpv/scripts/mpris.so /home/jee/.local/share/jellyfinmediaplayer/scripts/
  ];

  # Linking script
  system.userActivationScripts = {
    jellyfin-mpris = {
      text = ''
        ln -sf ${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so /home/jee/.local/share/jellyfinmediaplayer/scripts/
      '';
      deps = [];
    };
  };
}
