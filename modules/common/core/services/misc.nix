{ config, pkgs, lib, ... }:
with lib;
let
  device = config.modules.device;
  acceptedTypes = [ "desktop" "laptop" "hybrid" "lite" "armlaptop" ];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    # enable polkit for privilege escalation
    security.polkit.enable = true;
    programs.gnome-disks.enable = true;
    services = {
      udisks2.enable = true;
      fstrim.enable = true;
      dbus = {
        packages = with pkgs; [ dconf gcr udisks2 ];
        enable = true;
      };
    };
  };
}
