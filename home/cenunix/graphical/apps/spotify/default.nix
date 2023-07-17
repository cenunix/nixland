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
      theme = spicePkgs.themes.catppuccin-macchiato;
      colorScheme = "blue";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        playlistIcons
        lastfm
        genre
        historyShortcut
      ];
    };
  };
}
