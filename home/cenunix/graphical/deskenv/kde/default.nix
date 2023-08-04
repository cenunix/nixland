{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, ...
}:
with lib; let
  env = osConfig.modules.usrEnv;
  sys = osConfig.modules.system;
in
{
  config = mkIf ((sys.video.enable) && (env.desktop == "KDE") {
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
  }
