{
  # Using UEFI bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 20; # Maximum generations
      efi.canTouchEfiVariables = true;
      timeout = 1; # Time to confirm generation
    };
  };

  # kernelPackages = pkgs.linuxPackages_latest;
  # kernelParams = [ "intel_iommu=on" "iommu=pt" "vfio-pci.ids=1002:73df,1002:ab28" ];
  # kernelModules = [ "kvm-intel" ];
  # initrd.availableKernelModules = [ "amdgpu" "vfio-pci" ];
  # initrd.preDeviceCommands = ''
  #   DEVS="00003:00.0 00003:00.1"
  #   for DEV in $DEVS; do
  #     echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
  #   done
  #   modprobe -i vfio-pci
  # '';
}
