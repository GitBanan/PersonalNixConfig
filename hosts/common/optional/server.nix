{
  # Start Zrok
  #systemd = {
    # packages = [ pkgs.zrok ];
  # services.zrok-jellyfin = {
  #    description = "Zrok service for Jellyfin";
  #    enable = false;
  #    after = [ "jellyfin.service" ];
  #    wantedBy = [ "multi-user.target" ]; # Starts on boot
  #    serviceConfig = {
  #        Type = "exec";
  #        # Restart = "on-failure";
  #        ExecStart = "${pkgs.zrok}/bin/zrok share reserved jellyfinjeeserveraccess --headless";
  #    };
  #  };
  #};

}
