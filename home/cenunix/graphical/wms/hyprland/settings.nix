{ inputs, outputs, lib, config, pkgs, osConfig, ... }:
let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules) device;
  inherit (modules.style) pointerCursor;
in {
  wayland.windowManager.hyprland.extraConfig = let
    monitorConfig = builtins.concatStringsSep "\n"
      (builtins.map (monitor: "monitor=${monitor}") device.monitors);
  in ''
    ${monitorConfig}
  '';
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    exec-once = [
      "hyprctl setcursor ${pointerCursor.name} ${toString pointerCursor.size}"
      "hyprlock"
      "ags"
    ];
    input = {
      follow_mouse = 1;
      sensitivity = 0;
    };
    general = {
      gaps_in = 4;
      gaps_out = 4;
      border_size = 2;
      "col.active_border" = "rgb(a0acc5)";
      "col.inactive_border" = "rgb(7486a9)";
      allow_tearing = true;
      resize_on_border = true;
    };
    decoration = {
      screen_shader = mkIf (device.gpu == "nvidia")
        "${config.xdg.configHome}/hypr/shaders/bluelight.glsl";
      drop_shadow = true;
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgb(3c4252)";
      "col.shadow_inactive" = "rgb(3c4252)";
      rounding = 4;
      blur = {
        enabled = false;
        ignore_opacity = true;
        size = 6;
        passes = 2;
      };
    };
    animations = {
      enabled = true;
      bezier = [
        "pace, 0.46, 1, 0.29, 0.99"
        "overshot, 0.13, 0.99, 0.29, 1.1"
        "md3_decel, 0.05, 0.7, 0.1, 1"
      ];
      animation = [
        "windowsIn, 1, 3, md3_decel, slide"
        "windowsOut, 1, 3, md3_decel, slide"
        "windowsMove, 1, 3, md3_decel, slide"
        "fade, 1, 3, md3_decel"
        "workspaces, 1, 3, md3_decel"
        "specialWorkspace, 1, 3, md3_decel,slide"
      ];
    };
    dwindle = {
      pseudotile = false; # enable pseudotiling on dwindle
    };
    gestures = { workspace_swipe = false; };
    misc = {
      animate_manual_resizes = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      vfr = 1;
      vrr = 1;
    };
  };
}
