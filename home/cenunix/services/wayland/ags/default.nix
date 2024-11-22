{ config, lib, ... }:
let
  inherit (lib) hasPrefix mkIf removePrefix;

  # Configs
  # cfgDesktop = config.roles.desktop;
  flakeDir = "/home/cenunix/NixLand";

  agsConfigDir = "/Nixland/home/cenunix/services/wayland/ags/config";

  hmOpts = { lib, ... }: {
    options.programs.ags = {
      package = lib.mkOption {
        type = with lib.types; nullOr package;
        default = null;
      };

      astalLibs = lib.mkOption {
        type = with lib.types; nullOr (listOf package);
        default = null;
      };

      lockPkg = lib.mkOption {
        type = with lib.types; nullOr package;
        default = null;
      };

      configDir = lib.mkOption {
        type = lib.types.str;
        default = agsConfigDir;
      };
    };
  };
in {
  imports = [ hmOpts ./packages.nix ];
  config = {
    assertions = [{
      assertion = hasPrefix "/home/cenunix/" flakeDir;
      message = ''
        Your $FLAKE environment variable needs to point to a directory in
        the main users' home to use the AGS module.
      '';
    }];

    # Machine config
    # security.pam.services.astal-auth = { };
    # services.upower.enable = true;
  };
}
