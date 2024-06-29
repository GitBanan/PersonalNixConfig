# Anime game launchers
let
  aagl-gtk-on-nix = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");
in
{
  home.packages = [
    # aagl-gtk-on-nix.anime-game-launcher
    # aagl-gtk-on-nix.anime-borb-launcher
    # aagl-gtk-on-nix.honkers-railway-launcher
    # aagl-gtk-on-nix.honkers-launcher
    aagl-gtk-on-nix.wavey-launcher
  ];
}
