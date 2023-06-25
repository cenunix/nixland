{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  linux_x13s_pkg = {buildLinux, ...} @ args:
    buildLinux (args
      // rec {
        version = "6.3.5";
        modDirVersion = "6.3.8";

        src = pkgs.fetchFromGitHub {
          owner = "steev";
          repo = "linux";
          rev = "ab87d34f0b5ddd78093b8aa906939ae91984b2ab";
          sha256 = "sha256-aZMahaEi5wZr62sMlCF92pECXlQBZmurN1r8iouLMso=";
        };
        kernelPatches = [];

        extraMeta.branch = "lenovo-x13s-linux-6.3.y";
      }
      // (args.argsOverride or {}));

  linux_x13s = pkgs.callPackage linux_x13s_pkg {
    defconfig = "laptop_defconfig";
  };

  linuxPackages_x13s = pkgs.linuxPackagesFor linux_x13s;
  dtbname = "sc8280xp-lenovo-thinkpad-x13s.dtb";
in {
  boot = {
    loader.grub.enable = true;
    loader.grub.efiSupport = true;
    loader.grub.efiInstallAsRemovable = true;
    loader.grub.device = "nodev";
    loader.grub.configurationLimit = 20;
    #loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot";

    kernelPackages = linuxPackages_x13s;
    kernelParams = [
      "efi=noruntime"
      "clk_ignore_unused"
      "pd_ignore_unused"
      "root=PARTUUID=89578242-4aef-8e4f-8ecc-99829a0611c8"
      #"dtb=${config.boot.kernelPackages.kernel}/dtbs/qcom/${dtbname}"
    ];
    initrd = {
      includeDefaultModules = false;
      availableKernelModules = [
        "nvme"
        "phy_qcom_qmp_pcie"
        "pcie_qcom"
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
  };
  hardware.enableAllFirmware = true;
  hardware.firmware = [pkgs.linux-firmware pkgs.x13s-firmware];
}
