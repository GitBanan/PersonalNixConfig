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

  # Config Cloudflare tunnel
  services.cloudflared = {
    enable = true;
    # user = "jee";

    tunnels = {
      "3ec98f6-c196-4dca-975c-a488ec3b5a5c" = {
        credentialsFile = "/home/jee/.cloudflared/3ec98f6-c196-4dca-975c-a488ec3b5a5c.json";
        default = "http_status:404";
        #ingress = {
        #  "*.frostyhill.top" = { # Jellyfin
        #    service = "http://localhost:8096";
        #  };
        #};
      };
    };
  };

  systemd.services.cloudflared-autorun = {
    description = "Start cloudflared tunnel";
    enable = false;
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
