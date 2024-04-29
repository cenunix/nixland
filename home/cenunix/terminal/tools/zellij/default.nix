{ config, osConfig, inputs, pkgs, ... }:
let zjstatus = inputs.zjstatus.packages.${pkgs.system}.default;
in {
  home.packages = [ zjstatus ];
  programs.zellij = {
    enable = true;
    # enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      simplified_ui = true;
      pane_frames = false;
      default_layout = "default";
      ui.pane_frames.rounded_corners = true;
    };
  };
  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
        default_tab_template {
            children
            pane size=1 borderless=true {
                plugin location="file:${zjstatus}/bin/zjstatus.wasm" {
                    // plugin configuration...
                      
                  format_left   "{mode} #[fg=#89B4FA,bold]{session}"
                  format_center "{tabs}"
                  format_right  ""
                  format_space  ""

                  border_enabled  "false"
                  border_char     "─"
                  border_format   "#[fg=#6C7086]{char}"
                  border_position "top"

                  mode_normal  "#[bg=blue] "
                  mode_tmux    "#[bg=#ffc387] "

                  tab_normal   "#[fg=#9399b2,italic] {name} "
                  tab_active   "#[fg=#cdd6f4,bold,italic] {name} "

                  command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                  command_git_branch_format      "#[fg=blue] {stdout} "
                  command_git_branch_interval    "10"
                  command_git_branch_rendermode  "static"

                  datetime        "#[fg=#cdd6f4,italic] {format} "
                  datetime_format "%A, %d %b %Y %H:%M"
                  datetime_timezone "America/Los_Angeles"
                }
            }
        }
    }'';
}
