{ lib, pkgs, osConfig, inputs', ... }:
let
  inherit (lib) mkIf;

  sys = osConfig.modules;
  env = osConfig.modules.usrEnv;
  prg = sys.programs;

  catppuccin-mocha = pkgs.fetchzip {
    url =
      "https://github.com/PrismLauncher/Themes/releases/download/2024-10-21_1729507458/Catppuccin-Mocha-theme.zip";
    sha256 = "sha256-wJCz8NVfxwPpUM+DqeCBrych0DB/9GgDR3psBAE+/pc=";
  };

  # java packages that are needed by various versions or modpacks
  # different distributions of java may yield different results in performance
  # and thus I recommend testing them one by one to remove those that you do not
  # need in your configuration
  jdks = with pkgs; [
    temurin-jre-bin-8
    zulu8
    temurin-jre-bin-11
    temurin-jre-bin-17
    # temurin-jre-bin-18
    temurin-jre-bin
    zulu
    graalvm-ce
  ];

  additionalPrograms = with pkgs; [
    gamemode
    mangohud
    # jprofiler
  ];

  # glfw = if env.isWayland then pkgs.glfw3-minecraft else "false";
  glfw = with pkgs; [ glfw ];
in {
  config = mkIf prg.gaming.minecraft.enable {
    home = {
      # copy the catppuccin theme to the themes directory of PrismLauncher
      file.".local/share/PrismLauncher/themes" = {
        source = catppuccin-mocha;
        recursive = true;
      };

      packages = [
        # the successor to polyMC, which is now mostly abandoned
        (pkgs.prismlauncher.override {
          # get java versions required by various minecraft versions
          # "write once run everywhere" my ass
          inherit jdks;

          # wrap prismlauncher with programs in may need for workarounds
          # or client features
          inherit additionalPrograms;

          # prismlauncher's glfw version to properly support wayland
          # inherit glfw;
        })
      ];
    };
  };
}
