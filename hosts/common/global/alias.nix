{
  environment.shellAliases = {
    gacp = '' function _gacp(){ git add .; git commit -am "$1"; git push; };_gacp '';
    gfp = '' function _gacp(){ git fetch; git pull; };_gacp '';
  };
}
