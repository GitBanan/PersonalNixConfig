{
  pkgs,
  # config,
  ...
}: {
  environment.systemPackages = [ pkgs.unstable.cloudflared ];

  # Config Cloudflare tunnel
  services.cloudflared = {
    enable = true;
    package = pkgs.unstable.cloudflared;
    certificateFile = "/home/jee/.cloudflared/cert.pem";
    tunnels = {
      "c3ec98f6-c196-4dca-975c-a488ec3b5a5c" = {
        credentialsFile = "/home/jee/.cloudflared/c3ec98f6-c196-4dca-975c-a488ec3b5a5c.json";
        default = "http_status:404";
        ingress = {
          "jellyfin.frostyhill.top" = { # Jellyfin
            service = "http://localhost:8096";
          };
        };
      };
      "5f88497d-bde7-4a80-8c90-b0ea4fa2383b" = {
        credentialsFile = "/home/jee/.cloudflared/5f88497d-bde7-4a80-8c90-b0ea4fa2383b.json";
        default = "http_status:404";
        ingress = {
          "seerr.frostyhill.top" = { # Seerr
            service = "http://localhost:5055";
          };
        };
      };
    };
  };
  # Create DNS manually with "cloudflared tunnel route dns <your-tunnel> <your-public-domain>"
}
