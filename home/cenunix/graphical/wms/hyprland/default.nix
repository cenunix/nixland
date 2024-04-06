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
  device = osConfig.modules.device;
  env = osConfig.modules.usrEnv;

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
  imports = [
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];
  config = mkIf (env.isWayland && (env.desktop == "Hyprland")) {
    xdg.configFile."hypr/shaders".source = ./shaders;
    home.packages = with pkgs;
      [
        wlr-randr
      ]
      ++ optionals (device.gpu == "nvidia") [
        shadertoggle
        gojq
      ];

    services.wlsunset = {
      enable = device.gpu != "nvidia";
      latitude = "47.0";
      longitude = "-122.0";
      temperature = {
        day = 5300;
        night = 5000;
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
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}
