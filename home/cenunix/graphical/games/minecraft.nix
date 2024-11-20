{ lib, pkgs, osConfig, inputs', ... }:
let
  inherit (lib) mkIf;

  sys = osConfig.modules;
  env = osConfig.modules.usrEnv;
  prg = sys.programs;

  catppuccin-mocha = pkgs.fetchzip {
    url =
      "https://github.com/PrismLauncher/Themes/releases/download/2024-04-01_1711994750/Catppuccin-Mocha-theme.zip";
    sha256 = "sha256-BMJBJnIZZTP8l0O+8yOGSyW4S3SNOACa5ja/mqTRyzA=";
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
  glfw = with pkgs; [ glfw3-minecraft ];
in {
  config = mkIf prg.gaming.minecraft.enable {
    home = {
      # copy the catppuccin theme to the themes directory of PrismLauncher
      file.".local/share/PrismLauncher/themes/mocha" = {
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
