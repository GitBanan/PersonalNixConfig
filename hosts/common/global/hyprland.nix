{
  services = {
    xserver = {
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };

      # Enable the X11 windowing system.
      enable = true;
      # videoDrivers = [ "amdgpu" ];
    };

    # Enable the X11 windowing system.
    displayManager.sddm = {
      enable = true;
      wayland.enable = true; # Enable Wayland
    };
  };
}
