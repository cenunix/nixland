{ pkgs, config, lib, ... }:

let
  palette = config.colorScheme.palette;
  inherit (import ../../options.nix) waybarStyle;
in
# Configure & Theme Waybar
programs.waybar = {
enable = true;
package = pkgs.waybar;
settings = [{
layer = "top";
position = "top";

modules-left = [ "hyprland/window" "custom/startmenu" ];
modules-center = [ "network" "pulseaudio" "cpu" "hyprland/workspaces" "memory" "disk" "clock" ];
modules-right = [ "idle_inhibitor" "custom/themeselector" "custom/notification" "battery" "tray" ];
"hyprland/workspaces" = {
format = "{icon}";
format-icons = {
default = " ";
active = " ";
urgent = " ";
};
on-scroll-up = "hyprctl dispatch workspace e+1";
on-scroll-down = "hyprctl dispatch workspace e-1";
};
"clock" = {
format = "{: %I:%M %p}";
tooltip = false;
};
"hyprland/window" = {
max-length = 25;
separate-outputs = false;
};
"memory" = {
interval = 5;
format = " {}%";
tooltip = true;
};
"cpu" = {
interval = 5;
format = " {usage:2}%";
tooltip = true;
};
"disk" = {
format = "  {free}";
tooltip = true;
};
"network" = {
format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
format-ethernet = ": {bandwidthDownOctets}";
format-wifi = "{icon} {signalStrength}%";
format-disconnected = "󰤮";
tooltip = false;
};
"tray" = {
spacing = 12;
};
"pulseaudio" = {
format = "{icon} {volume}% {format_source}";
format-bluetooth = "{volume}% {icon} {format_source}";
format-bluetooth-muted = " {icon} {format_source}";
format-muted = " {format_source}";
format-source = " {volume}%";
format-source-muted = "";
format-icons = {
headphone = "";
hands-free = "";
headset = "";
phone = "";
portable = "";
car = "";
default = [ "" "" "" ];
};
on-click = "pavucontrol";
};
"custom/themeselector" = {
tooltip = false;
format = "";
# exec = "theme-selector";
on-click = "sleep 0.1 && theme-selector";
};
"custom/startmenu" = {
tooltip = false;
format = "";
# exec = "rofi -show drun";
on-click = "sleep 0.1 && rofi -show drun";
};
"idle_inhibitor" = {
format = "{icon}";
format-icons = {
activated = "";
deactivated = "";
};
tooltip = "true";
};
"custom/notification" = {
tooltip = false;
format = "{icon} {}";
format-icons = {
notification = "<span foreground='red'><sup></sup></span>";
none = "";
dnd-notification = "<span foreground='red'><sup></sup></span>";
dnd-none = "";
inhibited-notification = "<span foreground='red'><sup></sup></span>";
inhibited-none = "";
dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
dnd-inhibited-none = "";
};
return-type = "json";
exec-if = "which swaync-client";
exec = "swaync-client -swb";
on-click = "task-waybar";
escape = true;
};
"battery" = {
states = {
warning = 30;
critical = 15;
};
format = "{icon} {capacity}%";
format-charging = "󰂄 {capacity}%";
format-plugged = "󱘖 {capacity}%";
format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
on-click = "";
tooltip = false;
};
}];
style = ''
      	* {
      		font-size: 16px;
      		font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
          		font-weight: bold;
      	}
      	window#waybar {
      		    background-color: rgba(26,27,38,0);
          		border-bottom: 1px solid rgba(26,27,38,0);
          		border-radius: 0px;
      		    color: #1e1e2e;
      	}
      	#workspaces {
      		    background: linear-gradient(180deg, #1e1e2e, #cdd6f4);
          		margin: 5px;
          		padding: 0px 1px;
          		border-radius: 15px;
          		border: 0px;
          		font-style: normal;
          		color: #cdd6f4;
      	}
      	#workspaces button {
          		padding: 0px 5px;
          		margin: 4px 3px;
          		border-radius: 15px;
          		border: 0px;
          		color: #cdd6f4;
          		background-color: #cdd6f4;
          		opacity: 1.0;
          		transition: all 0.3s ease-in-out;
      	}
      	#workspaces button.active {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px;
          		min-width: 40px;
          		transition: all 0.3s ease-in-out;
          		opacity: 1.0;
      	}
      	#workspaces button:hover {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px;
          		opacity: 1.0;
      	}
      	tooltip {
        		background: #1e1e2e;
        		border: 1px solid #cdd6f4;
        		border-radius: 10px;
      	}
      	tooltip label {
        		color: #cdd6f4;
      	}
      	#window {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 0px 15px 50px 0px;
          		margin: 5px 5px 5px 0px;
          		padding: 2px 20px;
      	}
      	#memory {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px 50px 15px 50px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
      	#clock {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px 50px 15px 50px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
      	#idle_inhibitor {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 50px 15px 50px 15px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
      	#cpu {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 50px 15px 50px 15px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
      	#disk {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px 50px 15px 50px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
      	#battery {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
      	#network {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 50px 15px 50px 15px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
      	#tray {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px 0px 0px 50px;
          		margin: 5px 0px 5px 5px;
          		padding: 2px 20px;
      	}
      	#pulseaudio {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 50px 15px 50px 15px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
      	#custom-notification {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px 50px 15px 50px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
          #custom-themeselector {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px 50px 15px 50px;
          		margin: 5px;
          		padding: 2px 20px;
          }
      	#custom-startmenu {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 50px 15px 50px 15px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
      	#idle_inhibitor {
          		color: #cdd6f4;
          		background: #1e1e2e;
          		border-radius: 15px 50px 15px 50px;
          		margin: 5px;
          		padding: 2px 20px;
      	}
    '';
}
