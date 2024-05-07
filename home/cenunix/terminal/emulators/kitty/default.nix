{ inputs, outputs, lib, config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font.name = "monospace";
    font.size = 14;
    settings = {
      italic_font = "auto";
      bold_italic_font = "auto";
      mouse_hide_wait = 2;
      cursor_shape = "block";
      url_color = "#89ddff";
      url_style = "dotted";
      #Close the terminal =  without confirmation;
      confirm_os_window_close = 0;
      background_opacity = "1.0";
      window_padding_width = 10;
    };
    extraConfig = ''
      # Poimandres color scheme for kitty terminal emulator
      # https://github.com/guilhermedeandrade/poimandres-kitty-theme
      #
      # Based on Poimandres color theme for Visual Studio Code
      # https://github.com/drcmda/poimandres-theme

      foreground #a6accd
      background #14151e

      # Black
      color0 #14151e
      color8 #a6accd

      # Red
      color1 #d0679d
      color9 #d0679d

      # Green
      color2  #5de4c7
      color10 #5de4c7

      # Yellow
      color3  #fffac2
      color11 #fffac2

      # Blue
      color4  #89ddff
      color12 #add7ff

      # Magenta
      color5  #fcc5e9
      color13 #fae4fc

      # Cyan
      color6  #add7ff
      color14 #89ddff

      # White
      color7  #ffffff
      color15 #ffffff

      # Cursor
      cursor #ffffff
      cursor_text_color #14151e

      # Selection highlight
      selection_foreground none
      selection_background #28344a

      # The color for highlighting URLs on mouse-over
      # url_color #9ece6a
      url color #5de4c7

      # Window borders
      active_border_color #3d59a1
      inactive_border_color #101014
      bell_border_color #fffac2

      # Tab bar
      tab_bar_style fade
      tab_fade 1
      active_tab_foreground   #3d59a1
      active_tab_background   #16161e
      active_tab_font_style   bold
      inactive_tab_foreground #787c99
      inactive_tab_background #16161e
      inactive_tab_font_style bold
      tab_bar_background #101014

      # Title bar
      macos_titlebar_color #16161e    '';
  };
}
