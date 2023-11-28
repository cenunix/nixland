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
in
{
  imports = [
    inputs.arrpc.homeManagerModules.default
    ./arrpc.nix
  ];

  config = mkIf (builtins.elem device.type acceptedTypes) {
    home.packages = with pkgs; [
      webcord # webcord with vencord extension installed
    ];

    xdg.configFile = {
      "WebCord/Themes/mocha" = {
        source = ./mocha.theme.css;
      };

      # share my webcord configuration across devices
      "WebCord/config.json".source = config.lib.file.mkOutOfStoreSymlink "/home/cenunix/Personal/nicks/home/cenunix/graphical/apps/webcord/config.json";
    };

    # services.arrpc.enable = (device.type == "desktop");
  };
}
