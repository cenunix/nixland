{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  device = config.modules.device;
  acceptedTypes = ["desktop" "laptop" "hybrid" "lite" "armlaptop"];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    services = {
      lorri.enable = true;
      udisks2.enable = true;
      printing.enable = true;
      fstrim.enable = true;

      dbus = {
        packages = with pkgs; [dconf gcr udisks2];
        enable = true;
      };
    };
  };
}
