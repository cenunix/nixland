{ osConfig, ... }:
let
  inherit (osConfig) modules;
  inherit (modules.programs) default;
  workspaces = builtins.concatLists (builtins.genList (x:
    let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
    in [
      "$mod, ${ws}, workspace, ${toString (x + 1)}"
      "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
    ]) 10);
in {
  wayland.windowManager.hyprland.settings = {
    bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];

    bind = [
      "$mod, M, exit"
      "$mod, Q, killactive"
      "$mod, F, fullscreen"
      "$mod SHIFT, SPACE, togglefloating"
      "$mod, y, movetoworkspace, special"
      "$mod, t, togglespecialworkspace"
      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"
      "$mod SHIFT, h, movewindow, l"
      "$mod SHIFT, l, movewindow, r"
      "$mod SHIFT, k, movewindow, u"
      "$mod SHIFT, j, movewindow, d"
      "$mod, B, movecurrentworkspacetomonitor, DP-1"
      "$mod SHIFT, B, movecurrentworkspacetomonitor, DP-2"

      "$mod, I, exec, hyprlock"
      "$mod, Return, exec, ${default.terminal}"
      "$mod, E, exec, ${default.fileManager}"
      "$mod, N, exec, neovide"
      "$mod, R, exec, ags -b hypr -q; ags -b hypr"
      "$mod, Tab, exec, hyprctl dispatch overview:toggle"
      "$mod, U, exec, ags -b hypr -r 'recorder.start()'"
      "$mod, P, exec, ags -b hypr -r 'recorder.screenshot()'"
      "$mod SHIFT, P, exec, ags -b hypr -r 'recorder.screenshot(true)'"
      "$mod, D, exec, ags -b hypr -t launcher"
      "$mod, S, exec, rofi-rbw"
      "$mod, G, exec, wofi-bluetooth"
    ] ++ workspaces;

    bindle = [
      ", XF86MonBrightnessUp,exec,brightnessctl s 5%+"
      ", XF86MonBrightnessDown,exec,brightnessctl s 5%-"
      ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
      ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      ", XF86AudioMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
    ];
  };
}
