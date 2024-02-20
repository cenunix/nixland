{
  lib,
  osConfig,
  inputs,
  pkgs,
  ...
}:
with lib; let
  device = osConfig.modules.device;
  override = osConfig.modules.programs.override.program;
  acceptedTypes = ["laptop" "desktop"];
  spicePkgs = inputs.spicetify.packages.${pkgs.system}.default;
in {
  imports = [inputs.spicetify.homeManagerModule];
  config = mkIf (builtins.elem device.type acceptedTypes) {
    programs.spicetify = {
      spotifyPackage = pkgs.spotify;
      enable = true;
      # custom Dribbblish theme
      theme = spicePkgs.themes.Dribbblish;
      # specify that we want to use our custom colorscheme
      colorScheme = "custom";

      # color definition for custom color scheme. (rosepine)
      customColorScheme = {
        text = "ebbcba";
        subtext = "F0F0F0";
        sidebar-text = "e0def4";
        main = "07070b";
        sidebar = "07070b";
        player = "191724";
        card = "191724";
        shadow = "1f1d2e";
        selected-row = "797979";
        button = "31748f";
        button-active = "31748f";
        button-disabled = "555169";
        tab-active = "07070b";
        notification = "1db954";
        notification-error = "eb6f92";
        misc = "6e6a86";
      };
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        playlistIcons
        lastfm
        historyShortcut
      ];
    };
  };
}
