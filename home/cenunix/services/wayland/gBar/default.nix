{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, ...
}:
with lib; let
  device = osConfig.modules.device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in
{
  imports = [ inputs.gBar.homeManagerModules.x86_64-linux.default ];
  config = mkIf (builtins.elem device.type acceptedTypes) {
    programs.gBar = {
      enable = true;
      config = {
        Location = "L";
        EnableSNI = true;
        SNIIconSize = {
          Discord = 26;
          OBS = 23;
        };
        WorkspaceSymbols = [ " " " " ];
      };
    };
  };
}
