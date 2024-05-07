{ lib, osConfig, inputs, pkgs, ... }:
with lib;
let
  device = osConfig.modules.device;
  override = osConfig.modules.programs.override.program;
  acceptedTypes = [ "laptop" "desktop" ];
  spicePkgs = inputs.spicetify.packages.${pkgs.system}.default;
in {
  imports = [ inputs.spicetify.homeManagerModule ];
  config = mkIf (builtins.elem device.type acceptedTypes) {
    programs.spicetify = {
      # spotifyPackage = pkgs.spotify;
      enable = true;
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      # sidebarConfig = true;
      # enabledCustomApps = with spicePkgs.apps; [ lyrics-plus new-releases ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
      enabledExtensions = with spicePkgs.extensions;
        [
          # fullAppDisplay
          # shuffle # shuffle+ (special characters are sanitized out of ext names)
          # playlistIcons
          # historyShortcut
          # bookmark
          # fullAlbumDate
          # groupSession
          # popupLyrics
        ];
    };
  };
}
