{ inputs, outputs, lib, config, pkgs, osConfig, self, ... }:
with lib;
let
  catppuccin-mocha = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "0f2c393b11dd8174002803835ef7640635100ca3";
    hash = "sha256-iUnLLAQVMXFLyoB3wgYqUTx5SafLkvtOXK6C8EHK/nI=";
  };
  device = osConfig.modules.device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
    home.packages = with pkgs;
      [ (vesktop.override { withSystemVencord = false; }) ];
    xdg.configFile = {
      "vesktop/themes/mocha.theme.css" = { source = ./mocha.theme.css; };

      # share my webcord configuration across devices
      "vesktop/settings/settings.json".source =
        config.lib.file.mkOutOfStoreSymlink
        "/home/cenunix/NixLand/home/cenunix/graphical/apps/discord/settings.json";
    };
    # xdg.desktopEntries = {
    #   "vesktop" = {
    #     name = "vesktop";
    #     genericName = "Discord with Vencord built-in";
    #     comment = "Discord with Vencord built-in";
    #     exec = "${pkgs.vesktop}/bin/vesktop --disable-gpu";
    #     icon = "vesktop";
    #     terminal = false;
    #     type = "Application";
    #     settings = {
    #       StartupWMClass = "Vesktop";
    #       Keywords = "discord;vencord;electron;chat";
    #     };
    #   };
    # };

  };
}
