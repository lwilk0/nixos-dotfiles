{pkgs, ...}: {
  # Enable libvirt daemon
  virtualisation.libvirtd.enable = true;

  # Enable virt-manager for GUI management
  programs.virt-manager.enable = true;

  # Load necessary kernel modules
  boot.kernelModules = ["kvm-amd" "vfio-pci" "vfio_iommu_type1"];

  # Enable IOMMU
  boot.initrd.kernelModules = ["vfio-pci"];

  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
    OVMF
    libvirt
    looking-glass-client # For VM display
    scream # For VM audio
    pciutils # For lspci
  ];
  # Enable TPM emulation for QEMU/KVM VMs
  virtualisation.libvirtd.qemu = {
    swtpm.enable = true;
  };
  #boot.initrd.preDeviceCommands = ''
  #  # Replace with your GPU PCI addresses
  #  DEVS="0000:03:00.0 0000:03:00.1"
  #
  #  for DEV in $DEVS; do
  #    echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
  #  done
  #  modprobe -i vfio-pci
  #'';
}
