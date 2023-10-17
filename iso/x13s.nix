{ config
, lib
, pkgs
, modulesPath
, ...
}:
{
  imports = [ "${toString modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix" ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "efi=noruntime"
      "clk_ignore_unused"
      "pd_ignore_unused"
      "arm64.nopauth"
      # "iommu.passthrough=0"
      # "iommu.strict=0"
      # "pcie_aspm.policy=powersupersave"
    ];
    blacklistedKernelModules = [
      "qcom_q6v5_pas"
    ];
    supportedFilesystems = lib.mkForce [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
      "exfat"
      "fat8"
      "fat16"
      "fat32"
      "ext2"
      "ext3"
      "ext4"
    ];
    initrd = {
      availableKernelModules = [
        "nvme"
        "phy_qcom_qmp_pcie"
        # "pcie_qcom"
        "phy_qcom_qmp_ufs"
        "ufs_qcom"
        "i2c_hid_of"
        "i2c_qcom_geni"
        "leds_qcom_lpg"
        "pwm_bl"
        "qrtr"
        "pmic_glink_altmode"
        "gpio_sbu_mux"
        "phy_qcom_qmp_combo"
        "panel-edp"
        "msm"
        "phy_qcom_edp"
      ];
    };
    loader.efi.efiSysMountPoint = "/boot";
  };
  nixpkgs = {
    overlays = [
      (final: prev: {
        linux-firmware = prev.linux-firmware.overrideAttrs (old: {
          postInstall = ''
            rm $out/lib/firmware/qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn.xz
            rm $out/lib/firmware/qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn
          '';
        });
      })
    ];
    config = {
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
  };

  environment.systemPackages = with pkgs; [
    linux-firmware
    neovim
    git
  ];
  system.stateVersion = "23.05";
}
