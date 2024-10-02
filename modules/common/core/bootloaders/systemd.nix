{ inputs, outputs, lib, config, pkgs, ... }:
let
  inherit (lib) mkDefault mkIf;

  cfg = config.modules.system;
in {
  config = mkIf (cfg.boot.loader == "systemd-boot") {
    boot = {
      kernelPackages = pkgs.linuxPackages;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
