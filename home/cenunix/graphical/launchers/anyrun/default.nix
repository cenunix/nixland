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
  anyrunPkgs = inputs.anyrun.packages.${pkgs.system};
in
{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];
  config = mkIf (builtins.elem device.type acceptedTypes) {
    programs.anyrun = {
      enable = true;

      config = {
        plugins = with anyrunPkgs; [
          applications
          rink
          symbols
          dictionary
          translate
          websearch
        ];

        hidePluginInfo = true;
        closeOnClick = true;
      };
      extraCss = ''
        * {
          transition: 200ms ease-out;
          font-family: sansSerif;
          font-size: 1.1rem;
        }

        #window,
        #match,
        #entry,
        #plugin,
        #main {
          color: #cad3f5;
          background: transparent;
        }

        #match:selected {
          background: rgba(203, 166, 247, 0.7);
        }

        #match {
          padding: 3px;
          border-radius: 16px;
        }

        #entry {
          border-radius: 16px;
        }

        box#main {
          background: rgba(30, 30, 46, 0.7);
          border: 1px solid #28283d;
          border-radius: 24px;
          padding: 8px;
        }

        row:first-child {
          margin-top: 6px;
        }
      '';
    };
  };
}
