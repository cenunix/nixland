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
    grim -g "$(slurp -w 0 -b eebebed2)" /tmp/ocr.png && tesseract /tmp/ocr.png /tmp/ocr-output && wl-copy < /tmp/ocr-output.txt && notify-send "OCR" "Text copied!" && rm /tmp/ocr-output.txt -f
  '';
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    #!/bin/bash
    hyprctl keyword animation "fadeOut,0,8,slow" && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0 -b 5e81acd2)" - | swappy -f -; hyprctl keyword animation "fadeOut,1,8,slow"
  '';
  mylock = pkgs.writeShellScriptBin "mylock" ''
    #!/bin/bash
    gtklock -m "${pkgs.gtklock-userinfo-module}/lib/gtklock/userinfo-module.so" -m "${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so" -m "${self.packages.${pkgs.system}.gtklock-runshell-module}/lib/gtklock/runshell-module.so"
  '';
in {
  imports = [./config.nix];
  config = mkIf (env.isWayland && (env.desktop == "Hyprland")) {
    home.packages = with pkgs; [
      libnotify
      wf-recorder
      brightnessctl
      pamixer
      catppuccin-cursors
      # python39Packages.requests
      # tesseract5
      # swappy
      # ocr
      # screenshot
      # mylock
      wl-clipboard
      # pngquant
      cliphist
      grimblast
      air-status
    ];

    # services.wlsunset = {
    #   enable = true;
    #   latitude = "47.0";
    #   longitude = "-122.0";
    #   temperature = {
    #     day = 5300;
    #     night = 5000;
    #   };
    # };
    systemd.user.services = {
      swaybg = mkService {
        Unit.Description = "Wallpaper chooser";
        Service = {
          ExecStart = "${lib.getExe pkgs.swaybg} -i ${./wall.png}";
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
