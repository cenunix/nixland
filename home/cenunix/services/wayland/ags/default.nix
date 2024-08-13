{ config, lib, pkgs, inputs, ... }: {
  config = let
    inherit (lib) boolToString mkIf toLower;

    # Configs
    inherit (config.vars) hostName;
    flakeDir = config.environment.variables.FLAKE;

    # Packages
    astalTray = inputs.astal-tray.packages.${pkgs.system}.tray;
    gtkSessionLock = inputs.gtk-session-lock.packages.${pkgs.system}.default;
    ts-for-gir-src = inputs.ts-for-gir-src.packages.${pkgs.system}.default;
    buildNodeModules = dir: npmDepsHash:
      let
        pkg = pkgs.callPackage ({ buildNpmPackage, ... }:
          let
            inherit (builtins) readFile fromJSON;

            packageJSON = fromJSON (readFile (dir + /package.json));
          in buildNpmPackage {
            pname = packageJSON.name;
            inherit (packageJSON) version;

            src = dir;

            inherit npmDepsHash;
            dontNpmBuild = true;
          }) { };
      in "${pkg}/lib/node_modules/${pkg.pname}/node_modules";
  in {
    # Enable pam for ags
    security.pam.services.ags = { };

    services.upower.enable = true;

    home-manager.users."cenunix".imports = [
      inputs.ags.homeManagerModules.default

      ({ config, lib, ... }:
        let
          inherit (config.lib.file) mkOutOfStoreSymlink;
          inherit (lib) hasPrefix optionals removePrefix;

          configJs =
            # javascript
            ''
              Utils.execAsync('hyprpaper');

              import { transpileTypeScript } from './js/utils.js';

              export default (await transpileTypeScript('${hostName}')).default;
            '';

          agsPkg = config.programs.ags.finalPackage;
          agsConfigDir =
            "${removePrefix "/home/cenunix/" flakeDir}/nixosModules/ags";
        in {
          assertions = [{
            assertion = hasPrefix "/home/cenunix/" flakeDir;
            message = ''
              Your $FLAKE environment variable needs to point to a directory in
              the main users' home to use the AGS module.
            '';
          }];

          programs.ags = {
            enable = true;
            extraPackages = [ astalTray gtkSessionLock ];
          };

          home = {
            file = let
              inherit buildNodeModules;

              mkType = package: girName: {
                "${agsConfigDir}/config/types/@girs/${toLower girName}".source =
                  pkgs.callPackage ./mk-types {
                    inherit ts-for-gir-src package girName;
                  };
              };
            in ({
              # Generated types
              "${agsConfigDir}/config/types" = {
                source = "${agsPkg}/share/com.github.Aylur.ags/types";
                recursive = true; # To add other types inside the folder
              };
            } // (mkType gtkSessionLock "GtkSessionLock-0.1")
              // (mkType astalTray "AstalTray-0.1") // {
                # Out of store symlinks
                ".config/ags".source =
                  mkOutOfStoreSymlink "${flakeDir}/nixosModules/ags/config";

                # Generated JavaScript files
                "${agsConfigDir}/config/config.js".text = configJs;
                "${agsConfigDir}/config/ts/lockscreen/vars.ts".text =
                  # javascript
                  ''
                    export default {
                        mainMonitor: 'DP-1',
                        dupeLockscreen: true,
                        hasFprintd: ${boolToString (hostName == "wim")},
                    };
                  '';

                "${agsConfigDir}/config/node_modules".source =
                  buildNodeModules ./config
                  "sha256-Jt7HRrQ8xrpkku51zFbJ44IgPaKKXerZBJUyjo5VudQ=";
              } // (import ./icons.nix { inherit pkgs agsConfigDir; }));

            packages = with pkgs; [
              # ags
              coloryou
              dart-sass
              bun
              playerctl
              (callPackage ./clipboard { })
              ## gui
              pavucontrol # TODO: replace with ags widget
            ];
          };

          wayland.windowManager.hyprland = {
            settings = {
              animations = {
                bezier = [ "easeInOutBack,   0.68, -0.6, 0.32, 1.6" ];

                animation = [
                  "fadeLayersIn, 0"
                  "fadeLayersOut, 1, 3000, default"
                  "layers, 1, 8, easeInOutBack, slide left"
                ];
              };

              layerrule = [
                "noanim, ^(?!win-).*"

                # Lockscreen blur
                "blur, ^(blur-bg.*)"
                "ignorealpha 0.19, ^(blur-bg.*)"
              ];

              exec-once = [
                "ags"
                "sleep 3; ags -r 'App.openWindow(\"win-applauncher\")'"
              ];

              bind = [
                "$mainMod SHIFT, E    , exec, ags -t win-powermenu"
                "$mainMod      , D    , exec, ags -t win-applauncher"
                "$mainMod      , V    , exec, ags -t win-clipboard"
                "              , Print, exec, ags -t win-screenshot"
              ];
              binde = [
                ## Brightness control
                ", XF86MonBrightnessUp  , exec, ags -r 'Brightness.screen += 0.05'"
                ", XF86MonBrightnessDown, exec, ags -r 'Brightness.screen -= 0.05'"
              ];
              bindn = [ "    , Escape   , exec, ags -r 'closeAll()'" ];
              bindr = [
                "CAPS, Caps_Lock, exec, ags -r 'Brightness.fetchCapsState()'"
              ];
            };
          };
        })
    ];
  };

  # For accurate stack trace
  _file = ./default.nix;
}
