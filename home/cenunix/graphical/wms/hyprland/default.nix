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

  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };

  ocr = pkgs.writeShellScriptBin "ocr" ''
    #!/bin/bash
    grimblast --notify copysave area /tmp/ocr.png && tesseract /tmp/ocr.png /tmp/ocr-output && wl-copy < /tmp/ocr-output.txt && notify-send "OCR" "Text copied!" && rm /tmp/ocr-output.txt -f
  '';
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    #!/bin/bash
    hyprctl keyword animation "fadeOut,0,8,slow" && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0 -b 5e81acd2)" - | swappy -f -; hyprctl keyword animation "fadeOut,1,8,slow"
  '';
  mylock = pkgs.writeShellScriptBin "mylock" ''
    #!/bin/bash
    gtklock -m "${pkgs.gtklock-userinfo-module}/lib/gtklock/userinfo-module.so" -m "${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so" -m "${self.packages.${pkgs.system}.gtklock-runshell-module}/lib/gtklock/runshell-module.so"
  '';
  shadertoggle = pkgs.writeShellScriptBin "shadertoggle" ''
    #!/bin/bash
    set -e

    cfg=~/.config/hypr/shaders

    blank="blank_shader.glsl"
    alt="bluelight.glsl"

    current="$(hyprctl getoption decoration:screen_shader -j | ${pkgs.gojq}/bin/gojq -r '.str')"

    if [[ "$current" =~ (blank|EMPTY) ]] || [[ "$current" == "" ]]; then
        hyprctl keyword decoration:screen_shader "$cfg/$alt"
        echo set $alt
    else
        hyprctl keyword decoration:screen_shader "$cfg/$blank"
        echo set $blank
    fi
  '';
in {
  imports = [./config.nix];
  config = mkIf (env.isWayland && (env.desktop == "Hyprland")) {
    xdg.configFile."hypr/shaders".source = ./shaders;

    home.packages = with pkgs;
      [
        libnotify
        wf-recorder
        brightnessctl
        pamixer
        catppuccin-cursors
        python39Packages.requests
        tesseract5
        # swappy
        ocr
        # screenshot
        # mylock
        wl-clipboard
        cliphist
        grimblast
        air-status
      ]
      ++ optionals (device.gpu == "nvidia") [
        shadertoggle
        gojq
      ];

    services.wlsunset = {
      enable = (device.gpu != "nvidia");
      latitude = "47.0";
      longitude = "-122.0";
      temperature = {
        day = 5300;
        night = 5000;
      };
    };
    systemd.user.services = {
      swaybg = mkService {
        Unit.Description = "Wallpaper chooser";
        Service = {
          ExecStart = "${lib.getExe pkgs.swaybg} -i ${./catpuccino-4k.png}";
          Restart = "always";
        };
      };
      cliphist = mkService {
        Unit.Description = "Clipboard history";
        Service = {
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
          Restart = "always";
        };
      };
    };
    # fake a tray to let apps start
    # https://github.com/nix-community/home-manager/issues/2064
    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default.override {
        nvidiaPatches = (device.gpu == "nvidia") || (device.gpu == "hybrid-nv");
      };
      plugins = [
      ];
      systemdIntegration = true;
    };
  };
}
