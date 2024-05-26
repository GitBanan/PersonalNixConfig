{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    python3
    python311Packages.inquirerpy
    python312Packages.inquirerpy
  ];
}
