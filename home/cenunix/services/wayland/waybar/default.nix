{ outputs, config, lib, pkgs, inputs, ... }:
let
  commonDeps = with pkgs; [ coreutils gnugrep systemd ];
  # Function to simplify making waybar outputs
  mkScript = { name ? "script", deps ? [ ], script ? "", }:
    lib.getExe (pkgs.writeShellApplication {
      inherit name;
      text = script;
      runtimeInputs = commonDeps ++ deps;
    });
  # Specialized for JSON outputs
  mkScriptJson = { name ? "script", deps ? [ ], script ? "", text ? ""
    , tooltip ? "", alt ? "", class ? "", percentage ? "", }:
    mkScript {
      inherit name;
      deps = [ pkgs.jq ] ++ deps;
      script = ''
        ${script}
        jq -cn \
          --arg text "${text}" \
          --arg tooltip "${tooltip}" \
          --arg alt "${alt}" \
          --arg class "${class}" \
          --arg percentage "${percentage}" \
          '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
      '';
    };

in {
  # Let it try to start a few more times
  systemd.user.services.waybar = { Unit.StartLimitBurst = 30; };
  programs.waybar = {
    enable = false;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = true;
        passthrough = false;
        height = 40;
        margin = "6";
        position = "top";
        modules-left = [
          "custom/menu"
          "hyprland/workspaces"
          "hyprland/submap"
          "custom/currentplayer"
          "custom/player"
        ];

        modules-center =
          [ "cpu" "custom/gpu" "memory" "clock" "custom/unread-mail" ];

        modules-right = [
          "tray"
          "custom/rfkill"
          "network"
          "pulseaudio"
          "battery"
          "custom/hostname"
        ];

        clock = {
          interval = 1;
          format = "{:%d/%m %H:%M:%S}";
          format-alt = "{:%Y-%m-%d %H:%M:%S %z}";
          on-click-left = "mode";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = { format = "  {usage}%"; };
        "custom/gpu" = {
          interval = 5;
          exec = mkScript {
            script =
              "cat /sys/class/drm/card*/device/gpu_busy_percent | head -1";
          };
          format = "󰒋  {}%";
        };
        memory = {
          format = "  {}%";
          interval = 5;
        };

        pulseaudio = {
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 0%";
          format = "{icon} {volume}% {format_source}";
          format-muted = "󰸈 0% {format_source}";
          format-icons = { default = [ "󰕿" "󰖀" "󰕾" ]; };
          on-click = lib.getExe pkgs.pavucontrol;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        battery = {
          bat = "BAT0";
          interval = 10;
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          onclick = "";
        };
        "sway/window" = { max-length = 20; };
        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };
        "custom/menu" = {
          interval = 1;
          return-type = "json";
          exec = mkScriptJson {
            # deps = lib.optional hyprlandCfg.enable hyprlandCfg.package;
            text = ''$(grep PRETTY_NAME /etc/os-release | cut -d '"' -f2)'';
            # tooltip = ;
            class = "hyprctl activewindow -j | jq -e '.fullscreen' &>/dev/null";
          };
        };
        "custom/hostname" = {
          exec = mkScript {
            script = ''
              echo "$USER@$HOSTNAME"
            '';
          };
          on-click = mkScript {
            script = ''
              systemctl --user restart waybar
            '';
          };
        };
        "custom/unread-mail" = {
          interval = 5;
          return-type = "json";
          exec = mkScriptJson {
            deps = [ pkgs.findutils pkgs.procps ];
            script = ''
              count=$(find ~/Mail/*/Inbox/new -type f | wc -l)
              if pgrep mbsync &>/dev/null; then
                status="syncing"
              else
                if [ "$count" == "0" ]; then
                  status="read"
                else
                  status="unread"
                fi
              fi
            '';
            text = "$count";
            alt = "$status";
          };
          format = "{icon}  ({})";
          format-icons = {
            "read" = "󰇯";
            "unread" = "󰇮";
            "syncing" = "󰁪";
          };
        };
        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = mkScriptJson {
            deps = [ pkgs.playerctl ];
            script = ''
              all_players=$(playerctl -l 2>/dev/null)
              selected_player="$(playerctl status -f "{{playerName}}" 2>/dev/null || true)"
              clean_player="$(echo "$selected_player" | cut -d '.' -f1)"
            '';
            alt = "$clean_player";
            tooltip = "$all_players";
          };
          format = "{icon}{}";
          format-icons = {
            "" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = "󰓇 ";
            "ncspot" = "󰓇 ";
            "qutebrowser" = "󰖟 ";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
            "chromium" = " ";
          };
        };
        "custom/player" = {
          exec-if = mkScript {
            deps = [ pkgs.playerctl ];
            script = ''
              selected_player="$(playerctl status -f "{{playerName}}" 2>/dev/null || true)"
              playerctl status -p "$selected_player" 2>/dev/null
            '';
          };
          exec = mkScript {
            deps = [ pkgs.playerctl ];
            script = ''
              selected_player="$(playerctl status -f "{{playerName}}" 2>/dev/null || true)"
              playerctl metadata -p "$selected_player" \
                --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{artist}} - {{title}} ({{album}})"}' 2>/dev/null
            '';
          };
          return-type = "json";
          interval = 2;
          max-length = 30;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = mkScript {
            deps = [ pkgs.playerctl ];
            script = "playerctl play-pause";
          };
        };
        "custom/rfkill" = {
          interval = 1;
          exec-if = mkScript {
            deps = [ pkgs.util-linux ];
            script = "rfkill | grep '<blocked>'";
          };
        };
      };
    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = let
      # inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
      # inherit (config.colorscheme) colors;
      # toRGBA = color: opacity:
      # "rgba(${hexToRGBString "," (lib.removePrefix "#" color)},${opacity})";
      # css
    in ''
      * {
        font-family: Ubuntu Nerd Font, Maple Mono SC NF;
        font-size: 12pt;
        padding: 0;
        margin: 0 0.4em;
      }

      window#waybar {
        padding: 0;
        border-radius: 0.5em;
        background-color: rgba(17, 17, 27, 0.7);
        color: #cdd6f4;
      }
      .modules-left {
        margin-left: -0.65em;
      }
      .modules-right {
        margin-right: -0.65em;
      }

      #workspaces button {
        background-color: #313244;
        color: #cdd6f4;
        padding-left: 0.4em;
        padding-right: 0.4em;
        margin-top: 0.15em;
        margin-bottom: 0.15em;
      }
      #workspaces button.hidden {
        background-color: #313244;
        color: #cdd6f4;
      }
      #workspaces button.focused,
      #workspaces button.active {
        background-color: #1e1e2e;
        color: #cdd6f4;
      }

      #clock {
        padding-right: 1em;
        padding-left: 1em;
        border-radius: 0.5em;
      }

      #custom-menu {
        background-color: #6c7086;
        color: #cdd6f4;
        padding-right: 1.5em;
        padding-left: 1em;
        margin-right: 0;
        border-radius: 0.5em;
      }
      #custom-menu.fullscreen {
        background-color: #1e1e2e;
        color: #cdd6f4;
      }
      #custom-hostname {
        background-color: #6c7086;
        color: #cdd6f4;
        padding-right: 1em;
        padding-left: 1em;
        margin-left: 0;
        border-radius: 0.5em;
      }
      #custom-currentplayer {
        padding-right: 0;
      }
      #tray {
        color: #cdd6f4;
      }
      #custom-gpu, #cpu, #memory {
        margin-left: 0.05em;
        margin-right: 0.55em;
      }
    '';
  };
}
