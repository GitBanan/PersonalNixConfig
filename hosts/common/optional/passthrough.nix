{
  pkgs,
  # config,
  ...
}: let
  # VM_UUID = "ad2632db-0da0-4204-98b3-0592a185ebd0";
  VIRSH_GPU_VIDEO = "0000:03:00.0";
  VIRSH_GPU_AUDIO = "0000:03:00.1";
  # VIRSH_USB1 = "0000:00:14.0";

  startHook = ''
    echo "Start" > /home/jee/VM/Start

    #uncomment the next line if you're getting a black screen
    echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

    echo "${VIRSH_GPU_VIDEO}" > "/sys/bus/pci/devices/${VIRSH_GPU_VIDEO}/driver/unbind"
    echo "${VIRSH_GPU_AUDIO}" > "/sys/bus/pci/devices/${VIRSH_GPU_AUDIO}/driver/unbind"

    sync
    echo "3" > /proc/sys/vm/drop_caches
    sync
    echo "1" > /proc/sys/vm/compact_memory

    echo "End" > /home/jee/VM/Start
  '';

  stopHook = ''
    echo "Start" > /home/jee/VM/End

    echo "${VIRSH_GPU_VIDEO}" > "/sys/bus/pci/devices/${VIRSH_GPU_VIDEO}/driver/unbind"
    echo "${VIRSH_GPU_AUDIO}" > "/sys/bus/pci/devices/${VIRSH_GPU_AUDIO}/driver/unbind"

    echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

    echo "${VIRSH_GPU_VIDEO}" > /sys/bus/pci/drivers/amdgpu/bind
    echo "${VIRSH_GPU_AUDIO}" > /sys/bus/pci/drivers/snd_hda_intel/bind

    echo "End" > /home/jee/VM/End
  '';
in {
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "intel_iommu=on" "iommu=pt" "iommu=1" "disable_idle_d3=1" "video=efifb:off" ];
    kernelModules = [ "kvm-intel" "amdgpu" "vfio" "vfio_iommu_type1" "vfio-pci" ];

    # CHANGE: Don't forget to put your own PCI IDs here
    # extraModprobeConfig ="options vfio-pci ids=1002:73df,1002:ab28";
    # extraModprobeConfig ="options vfio-pci ids=0000:03:00.0,0000:03:00.1";

    # initrd.availableKernelModules = [ "amdgpu" "vfio-pci" ];
  };

  # Add binaries to path so that hooks can use it
  # systemd.services.libvirtd = {
  #   path = let
  #     env = pkgs.buildEnv {
  #       name = "qemu-hook-env";
  #       paths = with pkgs; [
  #         bash
  #         libvirt
  #         kmod
  #         systemd
  #         # ripgrep
  #         # sd
  #       ];
  #     };
  #   in [ env ];
  # };

  virtualisation.libvirtd.hooks.qemu = {
    "passHook" = pkgs.writeShellScript "passHook.sh" ''
      if [ ''$1 = "win10-pass" ] || [ ''$1 = "win11-pass" ]; then
        if [ ''$2 = "prepare" ] && [ ''$3 = "begin" ]; then
          ${startHook}
        fi

        if [ ''$2 = "release" ] && [ ''$3 = "end" ]; then
          ${stopHook}
        fi
      fi
    '';
  };
}
