{
  pkgs,
  config,
  ...
}: let
  task-waybar =
    pkgs.writeShellScriptBin "task-waybar"
    ''
      sleep 0.1
      ${pkgs.swaynotificationcenter}/bin/swaync-client -t &
    '';
in {
  home.packages = with pkgs; [
    swaynotificationcenter
    task-waybar
  ];
  home.file.".config/swaync/config.json".text = ''
        {
            "$schema": "/etc/xdg/swaync/configSchema.json",
            "positionX": "right",
            "positionY": "top",
            "control-center-margin-top": 10,
            "control-center-margin-bottom": 10,
            "control-center-margin-right": 10,
            "control-center-margin-left": 10,
            "notification-icon-size": 64,
            "notification-body-image-height": 100,
            "notification-body-image-width": 200,
            "timeout": 10,
            "timeout-low": 5,
            "timeout-critical": 0,
            "fit-to-screen": false,
            "control-center-width": 500,
            "control-center-height": 1025,
            "notification-window-width": 500,
            "keyboard-shortcuts": true,
            "image-visibility": "when-available",
            "transition-time": 200,
            "hide-on-clear": false,
            "hide-on-action": true,
            "script-fail-notify": true,
            "widgets": [
                "title",
                "buttons-grid",
                "mpris",
                "volume",
                "backlight",
                "dnd",
                "notifications"
            ],
            "widget-config": {
                "title": {
                    "text": "Notification Center",
                    "clear-all-button": true,
                    "button-text": "󰆴 Clear All"
                },
                "dnd": {
                    "text": "Do Not Disturb"
                },
                "label": {
                    "max-lines": 1,
                    "text": "Notification Center"
                },
                "mpris": {
                    "image-size": 96,
                    "image-radius": 7
                },
                "volume": {
                    "label": "󰕾"
                },
                "backlight": {
                    "label": "󰃟"
                },
                "buttons-grid": {
                    "actions": [
                        {
                            "label": "󰐥",
                            "command": "systemctl poweroff"
                        },
                        {
                            "label": "󰜉",
                            "command": "systemctl reboot"
                        },
                        {
                            "label": "",
                            "command": "thunar"
                        },
                        {
                            "label": "",
                            "command": "pavucontrol"
                        },
                        {
                            "label": "",
                            "command": "gimp"
                        },
                        {
                            "label": "󰕾",
                            "command": "pactl set-sink-mute @DEFAULT_SINK@ toggle"
                        },
                        {
                            "label": "󰍬",
                            "command": "pactl set-source-mute @DEFAULT_SOURCE@ toggle"
                        },
                        {
                            "label": "",
                            "command": "steam"
                        },
                        {
                            "label": "",
                            "command": "firefox"
                        },
                        {
                            "label": "",
                            "command": "obs"
                        }
                    ]
                }
        }
    }
  '';

  home.file.".config/swaync/style.css".text = ''
    * {
        font-family: Ubuntu;
        font-weight: bolder;
    }

    .control-center .notification-row:focus,
    .control-center .notification-row:hover {
        opacity: 0.9;
        background: #07070b
    }

    .notification-row {
        outline: none;
        margin: 10px;
        padding: 0;
    }

    .notification {
        background: transparent;
        padding: 0;
        margin: 0px;
    }

    .notification-content {
        background: #07070b;
        padding: 10px;
        border-radius: 5px;
        border: 2px solid #6c7086;
        margin: 0;
    }

    .notification-default-action {
        margin: 0;
        padding: 0;
        border-radius: 5px;
    }

    .close-button {
        background: #585b70;
        color: #07070b;
        text-shadow: none;
        padding: 0;
        border-radius: 5px;
        margin-top: 5px;
        margin-right: 5px;
    }

    .close-button:hover {
        box-shadow: none;
        background: #6c7086;
        transition: all .15s ease-in-out;
        border: none
    }


    .notification-action {
        border: 2px solid #6c7086;
        border-top: none;
        border-radius: 5px;
    }


    .notification-default-action:hover,
    .notification-action:hover {
        color: #cdd6f4;
        background: #cdd6f4
    }

    .notification-default-action {
        border-radius: 5px;
        margin: 0px;
    }

    .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 7px;
        border-bottom-right-radius: 7px
    }

    .notification-action:first-child {
        border-bottom-left-radius: 10px;
        background: #07070b
    }

    .notification-action:last-child {
        border-bottom-right-radius: 10px;
        background: #07070b
    }

    .inline-reply {
        margin-top: 8px
    }

    .inline-reply-entry {
        background: #07070b;
        color: #cdd6f4;
        caret-color: #cdd6f4;
        border: 1px solid #cdd6f4;
        border-radius: 5px
    }

    .inline-reply-button {
        margin-left: 4px;
        background: #07070b;
        border: 1px solid #cdd6f4;
        border-radius: 5px;
        color: #cdd6f4
    }

    .inline-reply-button:disabled {
        background: initial;
        color: #cdd6f4;
        border: 1px solid transparent
    }

    .inline-reply-button:hover {
        background: #07070b
    }

    .body-image {
        margin-top: 6px;
        background-color: #cdd6f4;
        border-radius: 5px
    }

    .summary {
        font-size: 16px;
        font-weight: 700;
        background: transparent;
        color: rgba(158, 206, 106, 1);
        text-shadow: none
    }

    .time {
        font-size: 16px;
        font-weight: 700;
        background: transparent;
        color: #cdd6f4;
        text-shadow: none;
        margin-right: 18px
    }

    .body {
        font-size: 15px;
        font-weight: 400;
        background: transparent;
        color: #cdd6f4;
        text-shadow: none
    }

    .control-center {
        background: #07070b;
        border: 2px solid #cdd6f4;
        border-radius: 5px;
    }

    .control-center-list {
        background: transparent
    }

    .control-center-list-placeholder {
        opacity: .5
    }

    .floating-notifications {
        background: transparent
    }

    .blank-window {
        background: alpha(black, 0)
    }

    .widget-title {
        color: #cdd6f4;
        background: #07070b;
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        font-size: 1.5rem;
        border-radius: 5px;
    }

    .widget-title>button {
        font-size: 1rem;
        color: #cdd6f4;
        text-shadow: none;
        background: #07070b;
        box-shadow: none;
        border-radius: 5px;
    }

    .widget-title>button:hover {
        background: #cdd6f4;
        color: #07070b;
    }

    .widget-dnd {
        background: #07070b;
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        font-size: large;
        color: #cdd6f4;
    }

    .widget-dnd>switch {
        border-radius: 5px;
        /* border: 1px solid #cdd6f4; */
        background: #cdd6f4;
    }

    .widget-dnd>switch:checked {
        background: #cdd6f4;
        border: 1px solid #cdd6f4;
    }

    .widget-dnd>switch slider {
        background: #07070b;
        border-radius: 5px
    }

    .widget-dnd>switch:checked slider {
        background: #07070b;
        border-radius: 5px
    }

    .widget-label {
        margin: 10px 10px 5px 10px;
    }

    .widget-label>label {
        font-size: 1rem;
        color: #cdd6f4;
    }

    .widget-mpris {
        color: #cdd6f4;
        background: #07070b;
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
    }

    .widget-mpris > box > button {
        border-radius: 5px;
    }

    .widget-mpris-player {
        padding: 5px 10px;
        margin: 10px
    }

    .widget-mpris-title {
        font-weight: 700;
        font-size: 1.25rem
    }

    .widget-mpris-subtitle {
        font-size: 1.1rem
    }

    .widget-buttons-grid {
        font-size: x-large;
        padding: 5px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        background: #cdd6f4;
    }

    .widget-buttons-grid>flowbox>flowboxchild>button {
        margin: 3px;
        background: #07070b;
        border-radius: 5px;
        color: #cdd6f4;
    }

    .widget-buttons-grid>flowbox>flowboxchild>button:hover {
        background: rgba(122, 162, 247, 1);
        color: #07070b;
    }

    .widget-menubar>box>.menu-button-bar>button {
        border: none;
        background: transparent
    }

    .topbar-buttons>button {
        border: none;
        background: transparent
    }

    .widget-volume {
        background: #cdd6f4;
        padding: 5px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        font-size: x-large;
        color: #cdd6f4;
    }

    .widget-volume>box>button {
        background: #cdd6f4;
        border: none
    }

    .per-app-volume {
        background-color: #07070b;
        padding: 4px 8px 8px;
        margin: 0 8px 8px;
        border-radius: 5px;
    }

    .widget-backlight {
        background: #cdd6f4;
        padding: 5px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        font-size: x-large;
        color: #cdd6f4
    }
  '';
}
