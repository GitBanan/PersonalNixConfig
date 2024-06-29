# configuration.nix
{
  # config,
  pkgs,
  ...
}:
let
   # aagl-gtk-on-nix = import (builtins.fetchTarball {
   # url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
   #  sha256 = "0cxhx0rdb1hd5as72jnnxirzdipi6y21si3hhci2bsbvxn5rph4b";
   # });
  # Or, if you follow Nixpkgs release 24.05:
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/release-24.05.tar.gz";
    sha256 = "0cxhx0rdb1hd5as72jnnxirzdipi6y21si3hhci2bsbvxn5rph4b";
  });
  aaglPkgs = aagl-gtk-on-nix.withNixpkgs pkgs;
in
{
  imports = [
    # aagl-gtk-on-nix.module
    aaglPkgs.module
  ];

  # programs.anime-game-launcher.enable = true;
  # programs.anime-games-launcher.enable = true;
  # programs.anime-borb-launcher.enable = true;
  # programs.honkers-railway-launcher.enable = true;
  # programs.honkers-launcher.enable = true;
  programs.wavey-launcher.enable = true;
}
