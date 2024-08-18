{
  pkgs,
  # config,
  ...
}: {
  # Using UEFI bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 20; # Maximum generations
      efi.canTouchEfiVariables = true;
      timeout = 1; # Time to confirm generation
    };

    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxKernel.packages.linux_6_10;
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

    kernelPatches = [
      { name = "fix-1";
        patch =  builtins.fetchurl {
          url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/sound/soc/soc-topology.c?id=e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7";
          sha256 = "sha256:1y5nv1vgk73aa9hkjjd94wyd4akf07jv2znhw8jw29rj25dbab0q";
        };
      }
      { name = "fix-2";
        patch = builtins.fetchurl {
          url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34";
          sha256 = "sha256:14xb6nmsyxap899mg9ck65zlbkvhyi8xkq7h8bfrv4052vi414yb";
        };
      }
    ];
  };
}
