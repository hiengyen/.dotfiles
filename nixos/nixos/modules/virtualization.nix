{ pkgs, ... }:
{
  ## Waydroid
  virtualisation.waydroid.enable = true;

  ## XEN
  # virtualisation.xen.enable = true;

  # Enable iGVT-g - technology 'slice iGPU
  virtualisation.kvmgt.enable = true;
  ## older Intel GPU
  # boot.extraModprobeConfig = "options i915 enable_guc=2";
  # boot.extraModprobeConfig = "options kvm_intel nested=1";
  environment.systemPackages = with pkgs; [
    virtiofsd
  ];

  ###Libvirt,QEMU,KVM

  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];
  # Install Virt-manager
  programs.virt-manager.enable = true;

  # virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  #Install Hypervisor
  boot.kernelParams = [ "intel_iommu=on" ];
  #Install Hypervisor
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.spiceUSBRedirection.enable = true; # SPICE redirects : to redirect USB device from host machine
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  hardware.graphics.enable = true; # 24.05 :   hardware.opengl.enable = true;

  ### Install VMware
  # virtualisation.vmware.host.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      # Bổ sung dòng này để libvirt tìm thấy virtiofsd khi chạy chế độ BIOS
      verbatimConfig = ''
        virtiofsd_path = "/run/current-system/sw/bin/virtiofsd"
      '';
    };
  };
}
