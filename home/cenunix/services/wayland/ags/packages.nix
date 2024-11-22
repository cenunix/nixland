{ config, lib, osConfig, pkgs, inputs, ... }:
let

  inherit (lib)
    attrValues boolToString optionals removeAttrs buildNodeModules
    buildGirTypes;

  inherit (osConfig.networking) hostName;

  configDir = "/home/cenunix/Nixland/home/cenunix/services/wayland/ags/config";
  cfg = config.programs.ags;
  # cfgDesktop = osConfig.roles.desktop;
in {
  # imports = [ inputs.ags.homeManagerModules.default ];
  config = {
    # Make these accessible outside these files
    programs.ags = {
      package = inputs.ags.packages.${pkgs.system}.ags.override {
        extraPackages = cfg.astalLibs;
        # inputs.ags.inputs.astal.packages.${pkgs.system}
        # inputs.gtk-session-lock.packages.${pkgs.system}.default

      };
      astalLibs = attrValues
        (removeAttrs inputs.ags.inputs.astal.packages.${pkgs.system} [
          "cava"
          "powerprofiles"
          "river"

          # Not libraries
          "docs"
          "gjs"
        ]) ++ [ inputs.gtk-session-lock.packages.${pkgs.system}.default ];

      lockPkg = pkgs.writeShellApplication {
        name = "lock";
        runtimeInputs = [ cfg.package ];
        text = ''
          if [ "$#" == 0 ]; then
            exec ags run ~/${configDir} -a lock
          else
            exec ags "$@" -i lock
          fi
        '';
      };
    };

    home = {
      packages = [
        (pkgs.writeShellApplication {
          name = "ags";
          runtimeInputs = [ cfg.package ];
          text = ''
            if [ "$#" == 0 ]; then
              exec ags run ~/${configDir} -a ${hostName}
            else
              exec ags "$@"
            fi
          '';
        })
        (pkgs.writeShellApplication {
          name = "agsConf";
          runtimeInputs = [ cfg.package ];
          text = ''
            exec ags run ~/${configDir} -a "$1"
          '';
        })
      ] ++ (builtins.attrValues {
        inherit (pkgs)
          playerctl pavucontrol # TODO: replace with ags widget
          wayfreeze;
      }) ++ (optionals false (builtins.attrValues { inherit (pkgs) ydotool; }));

      file = let
      in ((buildGirTypes {
        pname = "ags";
        configPath = "${configDir}/@girs";
        packages = cfg.astalLibs;
      }) // {
        "${configDir}/node_modules".source = buildNodeModules ./config
          "sha256-XNvj59XfO6f+04PatCOZ93tkkZ1K7jReZPqLGJL2Ojo=";

        "${configDir}/tsconfig.json".source =
          let inherit (inputs.ags.packages.${pkgs.system}) gjs;
          in pkgs.writers.writeJSON "tsconfig.json" {
            "$schema" = "https://json.schemastore.org/tsconfig";
            "compilerOptions" = {
              "experimentalDecorators" = true;
              "strict" = true;
              "target" = "ES2023";
              "moduleResolution" = "Bundler";
              "jsx" = "react-jsx";
              "jsxImportSource" = "${gjs}/share/astal/gjs/gtk3";
              "paths" = {
                "astal" = [ "${gjs}/share/astal/gjs" ];
                "astal/*" = [ "${gjs}/share/astal/gjs/*" ];
              };
              "skipLibCheck" = true;
              "module" = "ES2022";
              "lib" = [ "ES2023" ];
            };
          };

        "${configDir}/widgets/lockscreen/vars.ts".text =
          # javascript
          ''
            export default {
                mainMonitor: 'DP-1',
                dupeLockscreen: 'false,
                hasFprintd: 'false',
            };
          '';
      });
    };
  };

}
