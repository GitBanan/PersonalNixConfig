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

    vim
    vscodium

    nixfmt
    libxml2 # Format XML
    eclipses.eclipse-jee
    poppler-utils # pdf convertion

    lzip # Unzip
    unrar
    p7zip

    krita
  ];
}
