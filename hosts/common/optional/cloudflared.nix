{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = [ pkgs.cloudflared ];

  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = { };

  systemd.services.my_tunnel = {
    wantedBy = [ "multi-user.target" ];
    # after = [ "network.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];

    serviceConfig = {
      # ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=<myToken>";
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --credentials-file=/home/jee/cloudflare.token";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}
