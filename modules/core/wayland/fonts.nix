{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib; let
  env = config.modules.usrEnv;
in {
  config = mkIf (env.isWayland) {
    fonts = {
      fonts = with pkgs; [
        material-icons
        material-design-icons
        # roboto
        # work-sans
        # comic-neue
        # source-sans
        # twemoji-color-font
        # comfortaa
        # inter
        # lato
        # lexend
        # jost
        # dejavu_fonts
        iosevka-bin
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        font-awesome
        jetbrains-mono
        (nerdfonts.override {fonts = ["JetBrainsMono"];})
      ];

      enableDefaultFonts = false;

      # this fixes emoji stuff
      fontconfig = {
        defaultFonts = {
          monospace = [
            "Iosevka Term"
            "Iosevka Term Nerd Font Complete Mono"
            "Iosevka Nerd Font"
            "Noto Color Emoji"
          ];
          sansSerif = ["Lexend" "Noto Color Emoji"];
          serif = ["Noto Serif" "Noto Color Emoji"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };
  };
}
