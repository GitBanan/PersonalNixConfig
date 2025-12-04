{
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      # PermitRootLogin = "no";

      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";

      # Allow forwarding ports to everywhere
      # GatewayPorts = "clientspecified";
    };
  };

  users.users."jee".openssh.authorizedKeys.keys = [
    # content of authorized_keys file
    # note: ssh-copy-id will add user@your-machine after the public key
    # but we can remove the "@your-machine" part
    ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENDwtYhKezoBJ9Tpe2+G/aw2wxN9SYJdIlDoRXDiCYV Pixel 7
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINB6xtWy/537P1pbQy5DYm36MYozEz4mSXPXKUsa4WUK deck@steamdeck
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnLhtCqTkxR2iOJ+CukmSyG6f+cvC0i46yPXyMo+nLS jee@nano
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAFYkt9pfH/3jPilDkpPe6cjWjK4PkAY72DsbKdRj1Uq jee@hp260g9
    ''
  ];
}
