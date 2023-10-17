{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  device = config.modules.device;
  acceptedTypes = [ "server" "desktop" "laptop" "armlaptop" "hybrid" "lite" ];
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    nixpkgs.config.joypixels.acceptLicense = true;

    fonts = {
      packages = with pkgs; [
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
        material-icons
        material-design-icons
        iosevka-bin
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        font-awesome
        jetbrains-mono
        fira
        fira-code
        (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
      ];

      enableDefaultPackages = false;

      # this fixes emoji stuff
      fontconfig = {
        defaultFonts = {
          monospace = [
            "FiraCode"
            "FiraCode Nerd Font"
            # "Iosevka Term"
            # "Iosevka Term Nerd Font Complete Mono"
            # "Iosevka Nerd Font"
            "JoyPixels"
          ];
          sansSerif = [ "Fira Sans Condensed" "JoyPixels" ];
          serif = [ "Noto Serif" "JoyPixels" ];
          emoji = [ "JoyPixels" ];
        };
      };
    };
  };
}
