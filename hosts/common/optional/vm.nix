{
  # Setup VM
  virtualisation = {
    waydroid.enable = true;
    # virtualbox.host.enable = true; # For VirtualBox

    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        runAsRoot = false;
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };

  # Setup hypervisor for VM
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = ["qemu:///system"];
  #     uris = ["qemu:///system"];
  #   };
  # };
  # users.extraGroups.vboxusers.members = [ "jee" ]; # For VirtualBox

  programs = {
    virt-manager.enable = true;
  };
}
