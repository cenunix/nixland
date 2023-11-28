# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ab5c2823-ce6e-4938-a44f-fe8799d7a67b";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-6b89589a-fe7a-45c8-9234-93b0e3914a4a".device = "/dev/disk/by-uuid/6b89589a-fe7a-45c8-9234-93b0e3914a4a";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F6B0-304F";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/c4462073-f655-4c95-ad86-fc89a9877eb4";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-c14a72ec-211c-4e29-85ac-25db6fb2aa63".device = "/dev/disk/by-uuid/c14a72ec-211c-4e29-85ac-25db6fb2aa63";

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp10s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp8s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
