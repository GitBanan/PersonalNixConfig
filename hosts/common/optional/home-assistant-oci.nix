{
  pkgs,
  config,
  inputs,
  ...
}: {  
  virtualisation.oci-containers = {
    backend = "podman";

    containers = {
      homeassistant = {
        # Note: The image will not be updated on rebuilds, unless the version label changes
        image = "ghcr.io/home-assistant/home-assistant:stable";
        volumes = [
          "home-assistant:/config"
          "/mnt/hdd_4tb_cctv/hass:/media"
          "/etc/localtime:/etc/localtime:ro"
        ];
        # environment.TZ = "Europe/Berlin";
        extraOptions = [
          # Use the host network namespace for all sockets
          "--network=host"

          # Hardware acceleration (Intel/AMD/Nvidia fallback)
          "--device=/dev/dri"

          # Pass devices into the container, so Home Assistant can discover and make use of them
          # "--device=/dev/ttyACM0:/dev/ttyACM0"
        ];
      };

      frigate = {
        privileged = true;
        image = "ghcr.io/blakeblackshear/frigate:stable";

        volumes = [
          "frigate:/config"
          "/mnt/hdd_4tb_cctv/hass:/media/frigate"
          "/etc/localtime:/etc/localtime:ro"
        ];
        ports = [
            "8971:8971"
            # "5000:5000" # Internal unauthenticated access. Expose carefully.
            "8554:8554" # RTSP feeds
            "8555:8555/tcp" # WebRTC over tcp
            "8555:8555/udp" # WebRTC over udp
        ];
        extraOptions = [
          # Use the host network namespace for all sockets
          # "--network=host"

          # Hardware acceleration (Intel/AMD/Nvidia fallback)
          "--device=/dev/dri/renderD128"

          # Size caluclated for ~3 1440p cams
          "--shm-size=300m"

          # Pass devices into the container, so Home Assistant can discover and make use of them
          # "--device=/dev/ttyACM0:/dev/ttyACM0"
        ];
      };
    };
  };

  services.mosquitto = {
    enable = false;
    listeners = [
      {
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };
  
  networking.firewall.allowedTCPPorts = [
    8123  # HASS
    1883  # MQTT
  ];
}
