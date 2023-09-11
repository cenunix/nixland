{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, self
, ...
}:
with lib; let
  catppuccin-mocha = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "0f2c393b11dd8174002803835ef7640635100ca3";
    hash = "sha256-iUnLLAQVMXFLyoB3wgYqUTx5SafLkvtOXK6C8EHK/nI=";
  };
  project-path = builtins.getEnv "PWD";
  webcord-path = "${project-path}";
  device = osConfig.modules.device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
  arRPC = inputs.arrpc.packages.${pkgs.system}.arrpc;

in
{
  imports = [
    inputs.arrpc.homeManagerModules.default
    ./arrpc.nix
  ];

  config = mkIf (builtins.elem device.type acceptedTypes) {
    home.packages = with pkgs; [
      webcord-vencord # webcord with vencord extension installed
    ];
    systemd.user.services = {
      arRPC = lib.mkService {
        Unit.PartOf = ["graphical-session.target"];
        Unit.After = ["graphical-session.target"];
        Install.WantedBy = ["graphical-session.target"];

      Unit.Description = "Discord Rich Presence for browsers, and some custom clients";
        Service = {
          ExecStart = "${lib.getExe arRPC}";
          Restart = "always";
        };
      };
    };

    xdg.configFile = {
      "WebCord/Themes/mocha" = {
        source = ./mocha.theme.css;
      };

      # share my webcord configuration across devices
      "WebCord/config.json".source = config.lib.file.mkOutOfStoreSymlink "/home/cenunix/Personal/nicks/home/cenunix/graphical/apps/webcord/config.json";
    };

    services.arrpc.enable = true;
  };
}
