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
        text = "cdd6f4";
        subtext = "cdd6f4";
        sidebar-text = "cdd6f4";
        main = "07070b";
        sidebar = "07070b";
        player = "1e1e2e";
        card = "1e1e2e";
        shadow = "1f1d2e";
        selected-row = "45475a";
        button = "b4befe";
        button-active = "b4befe";
        button-disabled = "313244";
        tab-active = "07070b";
        notification = "a6e3a1";
        notification-error = "f38ba8";
        misc = "6c7086";
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
