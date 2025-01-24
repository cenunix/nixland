{ inputs, outputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.system.sound;
  device = config.modules.device;
  acceptedTypes = [ "armlaptop" ];
in {
  hardware.pulseaudio.enable = false;
  environment.systemPackages = with pkgs;
    [ alsa-utils ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [ alsa-ucm-conf ];
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      wireplumber.extraConfig = {
        "11-bluetooth-policy" = {
          "override.wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = false;
          };
        };
        "10-bluez" = {
          "override.monitor.bluez.properties" = {
            "bluez5.enable-msbc" = false;
            "bluez5.enable-sbc-xq" = true;
            "bluez5.hfphsp-backend" = "none";
            "bluez5.codecs" = [ "aac" "sbc_xq" "sbc" ];
            "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
          };
        };
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
