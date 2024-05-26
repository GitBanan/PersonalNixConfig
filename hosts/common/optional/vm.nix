{
  # Setup VM
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        runAsRoot = false;
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };

    # USB devices passthrough
    spiceUSBRedirection.enable = true;
  };

  programs = {
    virt-manager.enable = true;
  };
}
