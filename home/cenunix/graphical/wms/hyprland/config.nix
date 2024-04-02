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
  monitors = osConfig.modules.device.monitors;
  device = osConfig.modules.device;
  env = osConfig.modules.usrEnv;
in {
  wayland.windowManager.hyprland.extraConfig = ''
     # Cursor size
     env = XCURSOR_SIZE,16
     # Monitor
     # env test, test
     monitor=,highrr,auto,2
     ${builtins.concatStringsSep "\n" (builtins.map (monitor: ''monitor=${monitor}'') monitors)}

     # Autostart
     exec-once=/etc/polkit-kde-agent/agent
     exec-once = hyprctl setcursor "Bibata-Modern-Ice" 16
    # exec-once = run-as-service 'foot --server'
     exec-once = run-as-service waybar
     exec-once = run-as-service avizo-service
     exec-once = swww init
     exec-once = swww img ~/Personal/nicks/home/cenunix/graphical/wms/wall.png

     # Keyboard and mouse
     input {
      kb_file=
      kb_layout=
      kb_variant=
      kb_model=
      kb_options=
      kb_rules=

      follow_mouse=1

      touchpad {
        natural_scroll=no
      }
      sensitivity=0 # -1.0 - 1.0, 0 means no modification.
     }

     gestures {
      workspace_swipe = on
     }

     general {
      gaps_in=4
      gaps_out=4
      border_size = 2
      col.active_border = rgb(a0acc5)
      col.inactive_border= rgb(7486a9)
      allow_tearing = false
     }
     decoration {
     ${lib.optionalString (device.gpu == "nvidia") ''
      screen_shader = ~/.config/hypr/shaders/bluelight.glsl
    ''}
         #blur_new_optimizations = true
         #active_opacity = 0.8
         #inactive_opacity = 0.8
         #fullscreen_opacity = 0.8
         drop_shadow=true
         shadow_range=20
         shadow_render_power=3
         col.shadow=rgb(3c4252)
         col.shadow_inactive=rgb(3c4252)
         rounding=4
         #blur_ignore_opacity=true
         #blur=false
         #blur_size=6 # minimum 1
         blur {
             enabled=false
             ignore_opacity=true
             size=6
             passes=2
         }
         #blur_passes=2 # minimum 1, more passes = more resource intensive.
         # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
         # if you want heavy blur, you need to up the blur_passes.
         # the more passes, the more you can up the blur_size without noticing artifacts.
     }

     animations {
         enabled=1
         bezier=pace,0.46, 1, 0.29, 0.99
         bezier=overshot,0.13,0.99,0.29,1.1
         bezier = md3_decel, 0.05, 0.7, 0.1, 1
         animation=windowsIn,1,3,md3_decel,slide
         animation=windowsOut,1,3,md3_decel,slide
         animation=windowsMove,1,3,md3_decel,slide
         animation=fade,1,3,md3_decel
         animation=workspaces,1,3,md3_decel
         animation=specialWorkspace,1,3,md3_decel,slide
         #animation=border,0,3,md3_decel
     }

     # Layouts

     dwindle {
         pseudotile=0 # enable pseudotiling on dwindle
     }
     gestures {
         workspace_swipe=no
     }

     misc {
         animate_manual_resizes=true
         enable_swallow=true
         swallow_regex=foot|thunar
         disable_hyprland_logo=true
         disable_splash_rendering=true
         mouse_move_enables_dpms=true
         key_press_enables_dpms=true
         vfr=true
         vrr=1
     }
     debug {
         overlay = false
     }
     # example window rules
     # for windows named/classed as abc and xyz
     #windowrule=move 69 420,abc
     #windowrule=size 420 69,abc
     #windowrule=tile,xyz
     #windowrule=float,abc
     #windowrule=pseudo,abc
     #windowrule=monitor 0,xyz

     windowrule=tile,^(neovide)$
     windowrule=forceinput,^(neovide)$
     windowrulev2 = move 30 100,class:^(wofi)$
     windowrulev2=opaque,title:^(Picture-in-Picture)$
     windowrule=opaque,^(com.obsproject.Studio)$
     windowrule=opaque,^(firefox)$
     windowrule=fullscreen,^(csgo_linux64)$
     windowrule=fullscreen,^(Skyrim Special Edition)$

     layerrule = blur, ^(gtk-layer-shell|anyrun)$
     layerrule = ignorezero, ^(gtk-layer-shell|anyrun)$

     # resize and relocate via submap
     # normal movement, shift + key for resizing
     #bind = SUPER, R, exec, hyprctl --batch keyword "general:col.active_border $yellow;"
     #bind = SUPER, R, exec, hyprctl --batch keyword "general:col.group_border_active $peach;"
     bind = SUPER, R, submap, re(locate/Size)
     bind=,mouse:276,pass,^(discord)$
     submap = re(locate/Size)
     binde = , l , moveactive, 20 0
     binde = , h , moveactive, -20 0
     binde = , right, moveactive, 20 0
     binde = , left , moveactive, -20 0
     binde = , j , moveactive, 0 20
     binde = , down , moveactive, 0 20
     binde = , k , moveactive, 0 -20
     binde = , up , moveactive, 0 -20
     binde = SHIFT, l , resizeactive, 20 0
     binde = SHIFT, right, resizeactive, 20 0
     binde = SHIFT, h , resizeactive, -20 0
     binde = SHIFT, left , resizeactive, -20 0
     binde = SHIFT, j , resizeactive, 0 20
     binde = SHIFT, down , resizeactive, 0 20
     binde = SHIFT, k , resizeactive, 0 -20
     binde = SHIFT, up , resizeactive, 0 -20
     #bind = , escape, exec, hyprctl --batch keyword "general:col.active_border $mauve $sapphire 45deg;"
     #bind = , escape, exec, hyprctl --batch keyword "general:col.group_border_active $green;"
     bind = , escape, submap, reset
     #bind = SUPER, R, exec, hyprctl --batch keyword "general:col.active_border $mauve $sapphire 45deg;"
     #bind = SUPER, R, exec, hyprctl --batch keyword "general:col.group_border_active $green;"
     bind = SUPER, R, submap, reset
     #bind = , return, exec, hyprctl --batch keyword "general:col.active_border $mauve $sapphire 45deg;"
     #bind = , return, exec, hyprctl --batch keyword "general:col.group_border_active $green;"
     bind = , return, submap, reset
     submap = reset
     bind=SUPER,F,fullscreen

     # some nice mouse binds
     bindm=SUPER,mouse:272,movewindow
     bindm=SUPER,mouse:273,resizewindow

     # Keybinds
     bind=SUPER,RETURN,exec,kitty
     bind=SUPER,Q,killactive,
     bind=SUPER,M,exit,
     bind=SUPER,E,exec,thunar
     bind=SUPER_SHIFT,SPACE,togglefloating,
     #bind=SUPER,P,pseudo,
     # Screenshots

     bind=SUPER,U,exec,ags -r 'recorder.start()'
     bind=SUPER,P,exec,ags -r 'recorder.screenshot()'
     bind=SUPER_SHIFT,P,exec,ags -r 'recorder.screenshot(true)'

     bind=SUPER,N,exec,neovide
     bind=SUPER,I,exec,hyprlock
     bind=SUPER,D,exec,ags -t launcher
     bind=SUPER,S,exec,rofi-rbw
     bind=SUPER,G,exec,rofi-bluetooth

     bind=,Print,exec,wscreenshot -sf

     bind=,XF86MonBrightnessUp,exec,lightctl up
     bind=,XF86MonBrightnessDown,exec,lightctl down
     binde=, XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
     bindl=, XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
     bindl=, XF86AudioMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle
     bind=SUPER,h,movefocus,l
     bind=SUPER,l,movefocus,r
     bind=SUPER,k,movefocus,u
     bind=SUPER,j,movefocus,d

     bind=SUPER_SHIFT,h,movewindow,l
     bind=SUPER_SHIFT,l,movewindow,r
     bind=SUPER_SHIFT,k,movewindow,u
     bind=SUPER_SHIFT,j,movewindow,d
     bind=SUPER,B,movecurrentworkspacetomonitor,DP-1
     bind=SUPER_SHIFT,B,movecurrentworkspacetomonitor,DP-2

     bind=SUPER,1,workspace,1
     bind=SUPER,2,workspace,2
     bind=SUPER,3,workspace,3
     bind=SUPER,4,workspace,4
     bind=SUPER,5,workspace,5
     bind=SUPER,6,workspace,6
     bind=SUPER,7,workspace,7
     bind=SUPER,8,workspace,8
     bind=SUPER,9,workspace,9
     bind=SUPER,0,workspace,10

     bind=SUPER_SHIFT,1,movetoworkspace,1
     bind=SUPER_SHIFT,2,movetoworkspace,2
     bind=SUPER_SHIFT,3,movetoworkspace,3
     bind=SUPER_SHIFT,4,movetoworkspace,4
     bind=SUPER_SHIFT,5,movetoworkspace,5
     bind=SUPER_SHIFT,6,movetoworkspace,6
     bind=SUPER_SHIFT,7,movetoworkspace,7
     bind=SUPER_SHIFT,8,movetoworkspace,8
     bind=SUPER_SHIFT,9,movetoworkspace,9
     bind=SUPER_SHIFT,0,movetoworkspace,10

     bind=SUPER,y,movetoworkspace,special
     bind=SUPER,t,togglespecialworkspace
  '';
}
