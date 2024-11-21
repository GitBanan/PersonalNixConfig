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

    nix-output-monitor # Monitor build logs during Nix compile
  ];
}
