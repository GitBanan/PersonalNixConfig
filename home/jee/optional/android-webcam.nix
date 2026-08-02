{
  pkgs,
  # config,
  ...
}: {
  xdg.desktopEntries = {
    andcamscrcpy = {
      name = "Android Virtual Camera scrcpy";  # Check id using scrcpy --list-cameras
      exec = "${pkgs.writeScript "andcamscrcpy" ''
        #!${pkgs.bash}/bin/bash
        ${pkgs.android-tools}/bin/adb start-server
        ${pkgs.scrcpy}/bin/scrcpy --camera-facing=front --video-source=camera --no-audio --v4l2-sink=/dev/video0 -m1024
      ''}";
      categories = [ "AudioVideo" "Player" "Video" ];
      genericName = "Start virtual camera using ADB and scrcpy";
      icon = "camera-web";
      terminal = true;
    };

    andcamffmpeg = {  # IP changes on every connect, need a better way
      noDisplay = true; # Hidden
      name = "Android Virtual Camera ffmpeg";  # Check id using scrcpy --list-cameras
      exec = "${pkgs.writeScript "andcamffmpeg" ''
        #!${pkgs.bash}/bin/bash
        ${pkgs.ffmpeg}/bin/ffmpeg -f mjpeg -i https://ipcam:FFMpeg4444@192.168.0.101:4444/video/h264 -pix_fmt yuv420p -f v4l2 /dev/video0
      ''}";
      categories = [ "AudioVideo" "Player" "Video" ];
      genericName = "Start virtual camera using ffmpeg";
      icon = "camera-web";
      terminal = true;
    };
  };
}
