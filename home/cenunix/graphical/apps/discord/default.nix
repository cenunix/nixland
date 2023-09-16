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
  device = osConfig.modules.device;
  acceptedTypes = [ "desktop" "laptop" "armlaptop" ];
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    home.packages = with pkgs; [
      (pkgs.discord.override {
        # remove any overrides that you don't want
        withOpenASAR = true;
        withVencord = true;
      })
    ];
    xdg.configFile = {
      "Vencord/themes/mocha" = {
        source = ./mocha.theme.css;
      };

      # share my webcord configuration across devices
      "Vencord/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/home/cenunix/Personal/nicks/home/cenunix/graphical/apps/discord/settings.json";
    };
  };
}
