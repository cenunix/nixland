{ inputs, outputs, lib, config, pkgs, ... }:
with lib;
let sys = config.modules.system.bluetooth;
in {
  config = mkIf (sys.enable) {
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
      #hsphfpd.enable = true;
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

    # https://nixos.wiki/wiki/Bluetooth
    services.blueman.enable = true;
  };
}
