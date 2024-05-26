{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Kate packages
    kdePackages.kate
    nodePackages_latest.bash-language-server
    nil # Nix bash
  ];
}
