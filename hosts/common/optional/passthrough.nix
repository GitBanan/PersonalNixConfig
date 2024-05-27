{
  pkgs,
  # config,
  ...
}: let
  # VM_UUID = "ad2632db-0da0-4204-98b3-0592a185ebd0";
  # VIRSH_GPU_VIDEO = "0000:03:00.0";
  # VIRSH_GPU_AUDIO = "0000:03:00.1";
  # VIRSH_USB1 = "0000:00:14.0";

  startHook = ''
    echo "Start" > /home/jee/VM/start
  '';

  stopHook = ''
    echo "stop" > /home/jee/VM/stop
  '';
in {
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "intel_iommu=on" "iommu=pt" ];
    kernelModules = [ "kvm-intel" "vfio" "vfio_iommu_type1" "vfio-pci" ];

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
    "win10" = pkgs.writeShellScript "win10.sh" ''
      if [ ''$1 = "win10" ] || [ ''$1 = "win11" ]; then
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
