{
  # pkgs,
  # config,
  ...
}: {
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "intel_iommu=on" "iommu=pt" ];
    kernelModules = [ "kvm-intel" "vfio" "vfio_iommu_type1" "vfio-pci" "vfio_virqfd" ];

    # CHANGE: Don't forget to put your own PCI IDs here
    # extraModprobeConfig ="options vfio-pci ids=1002:73df,1002:ab28";

    # initrd.availableKernelModules = [ "amdgpu" "vfio-pci" ];
    # initrd.preDeviceCommands = ''
    #   DEVS="00003:00.0 00003:00.1"
    #   for DEV in $DEVS; do
    #     echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    #   done
    #   modprobe -i vfio-pci
    # '';
  };
}
