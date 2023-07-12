{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  device = config.modules.device;
  acceptedTypes = ["server" "desktop" "laptop" "armlaptop" "hybrid" "lite"];
in {
  config = mkIf (builtins.elem device.type acceptedTypes) {
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
            "JetBrainsMono"
            "JetBrainsMono Nerd Font"
            # "Iosevka Term"
            # "Iosevka Term Nerd Font Complete Mono"
            # "Iosevka Nerd Font"
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
