{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  env = config.modules.usrEnv;
  device = config.modules.device;
  acceptedTypes = ["desktop" "laptop"];
in {
  imports = [./services.nix];

  config = mkIf (env.isWayland) {
    # nixpkgs.overlays = with inputs; [nixpkgs-wayland.overlay];

    environment = {
      variables = {
        NIXOS_OZONE_WL = "1";
        # __GL_GSYNC_ALLOWED = "0";
        # __GL_VRR_ALLOWED = "0";
        _JAVA_AWT_WM_NONEREPARENTING = "1";
        SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
        DISABLE_QT5_COMPAT = "0";
        GDK_BACKEND = "wayland";
        ANKI_WAYLAND = "1";
        DIRENV_LOG_FORMAT = "";
        WLR_DRM_NO_ATOMIC = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_QPA_PLATFORMTHEME = "qt5ct";
        QT_STYLE_OVERRIDE = "kvantum";
        MOZ_ENABLE_WAYLAND = "1";
        # WLR_BACKEND = "vulkan";
        # WLR_RENDERER = "vulkan";
        WLR_NO_HARDWARE_CURSORS = "1";
        XDG_SESSION_TYPE = "wayland";
        # SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        BROWSER = "firefox";
        # WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
      };
      loginShellInit = ''
        dbus-update-activation-environment --systemd DISPLAY
        eval $(gnome-keyring-daemon --start --components=ssh)
        eval $(ssh-agent)
      '';
    };

    hardware = {
      opengl = mkMerge [
        {
          enable = true;
          driSupport = true;
          extraPackages = with pkgs; [
            vaapiVdpau
            libvdpau-va-gl
          ];
        }
        (mkIf (builtins.elem device.type acceptedTypes) {
          driSupport32Bit = true;
        })
        (mkIf (device.type == "armlaptop") {
          package = pkgs.mesa;
        })
      ];
      pulseaudio.support32Bit = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = false;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        inputs.xdg-portal-hyprland.packages.${pkgs.system}.default
      ];
    };

    sound = {
      enable = true;
      mediaKeys.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gnome3.adwaita-icon-theme
      xdg-utils
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
    ];
  };
}
