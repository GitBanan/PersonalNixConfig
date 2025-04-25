{
  environment.shellAliases = {
    gacp = '' function _gacp(){ git add .; git commit -am "$1"; git push; };_gacp '';
    gfp = ''git fetch && git pull'';
  };
}
