{ config
, pkgs
, lib
, ...
}:
with lib; let
  device = config.modules.device;
  acceptedTypes = [ "desktop" "laptop" "hybrid" "lite" "armlaptop" ];
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    # enable polkit for privilege escalation
    security.polkit.enable = true;
    services = {
      udisks2.enable = true;
      printing = {
        enable = true;
        drivers = [
          pkgs.gutenprint
          pkgs.brlaser
          pkgs.brgenml1lpr
          pkgs.brgenml1cupswrapper
        ];
      };
      fstrim.enable = true;
      dbus = {
        packages = with pkgs; [ dconf gcr udisks2 ];
        enable = true;
      };
    };
  };
}
