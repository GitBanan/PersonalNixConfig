{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nbfc-linux.default
  ];

  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig.Type = "simple";
    path = [pkgs.kmod];
    script = "${inputs.nbfc-linux.packages.x86_64-linux.default}/${command}";
    wantedBy = ["multi-user.target"];
  };
}
