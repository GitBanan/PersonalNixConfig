{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    android-tools # ADB
    scrcpy
  ];

  boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Pixel Webcam"
    '';
  };
}
