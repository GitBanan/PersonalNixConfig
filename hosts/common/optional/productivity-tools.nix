{
  pkgs,
  # config,
  ...
}: {
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # For running Epic Games store
  # hardware.graphics.enable32Bit = true;

  programs = {
    # Enable optional KDE features
    kdeconnect.enable = true;

    firefox.enable = true;
  };

  environment.systemPackages = with pkgs; [
    localsend
  ];
}
