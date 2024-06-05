{ config, pkgs, lib, ... }:
with lib;
let
  device = config.modules.device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    # enable polkit for privilege escalation
    security.polkit.enable = true;
    programs.gnome-disks.enable = true;
    services = {
      udisks2.enable = true;
      fstrim.enable = true;
      avahi.enable = true;
      gvfs.enable = true; # Mount, trash, and other functionalities
      flatpak.enable = true;
      dbus = {
        packages = with pkgs; [ dconf gcr udisks2 ];
        enable = true;
      };
      samba-wsdd = {
        enable = true;
        openFirewall = true;
        discovery = true;
        hostname = "SMBNIX";
      };
    };
  };
}
