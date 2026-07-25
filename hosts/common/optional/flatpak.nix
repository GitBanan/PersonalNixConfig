{
  pkgs,
  # config,
  ...
}: {
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    enable = false;
    wantedBy = [ "multi-user.target" ];
    after = [ "dnscrypt-proxy.service"];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
