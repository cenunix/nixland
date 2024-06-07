{ inputs, outputs, lib, config, pkgs, ... }:
with lib;
let sys = config.modules.system.bluetooth;
in {
  config = mkIf (sys.enable) {
    # https://nixos.wiki/wiki/Bluetooth
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez-experimental;
      # hsphfpd.enable = true;
      powerOnBoot = true;
      disabledPlugins = [ "sap" ];
      settings = {
        General = {
          JustWorksRepairing = "always";
          Experimental = true;
          MultiProfile = "multiple";
        };
      };
    };
    services.blueman.enable = true;
  };
}
