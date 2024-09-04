{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mergerfs
  ];

  fileSystems."/storage/pool" = {
    fsType = "fuse.mergerfs";
    device = "/mnt/HDD_4TB:/mnt/Jee_HDD";
    options = ["cache.files=partial" "dropcacheonclose=true" "category.create=mfs"];
  };
}
