{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  cfg = config.modules.system.sound;
  device = config.modules.device;
in
{
  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol

  ]
  ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
    # additional packages for arm laptop (x13s)
    alsa-ucm-conf-x13s
  ];
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
  environment.etc = mkIf (device.hasBluetooth) {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };
}
