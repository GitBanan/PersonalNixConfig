{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Libreoffice
    libreoffice-qt-fresh
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH
  ];
}
