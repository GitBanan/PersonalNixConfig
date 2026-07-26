{
  environment.shellAliases = {
    gs = "git status";
    fu = "nix flake update";
  };

  programs.bash.shellAliases = {
    gacp = '' function _gacp(){ git add .; git commit -am "$1"; git push; };_gacp '';
  };
}
