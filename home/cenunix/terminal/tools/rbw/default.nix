{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wtype
    rofi-rbw-wayland
    rofi
  ];
  programs.rbw = {
    enable = true;
    settings.email = "caden.hargrave@gmail.com";
    # settings.base_url = "https://api.bitwarden.com";
    settings.pinentry = "gnome3";
  };
  xdg.configFile."rofi/config.rasi".text = ''
        configuration{
        modi: "run,drun,window";
        icon-theme: "Oranchelo";
        show-icons: true;
        terminal: "foot";
        drun-display-format: "{icon} {name}";
        location: 0;
        disable-history: false;
        hide-scrollbar: true;
        display-drun: "   Apps ";
        display-run: "   Run ";
        display-window: " 﩯  Window";
        display-Network: " 󰤨  Network";
        sidebar-mode: true;
    }

    @theme "catppuccin-macchiato"
  '';
  xdg.configFile."rofi/catppuccin-macchiato.rasi".text = ''
            * {
        bg-col:  #07070b;
        bg-col-light: #24273a;
        border-col: #07070b;
        selected-col: #24273a;
        blue: #89b4fa;
        fg-col: #cdd6f4;
        fg-col2: #74c7ec;
        grey: #6e738d;

        width: 1000;
        font: "VictorMono Nerd Font 12";
    }

    element-text, element-icon , mode-switcher {
        background-color: inherit;
        text-color:       inherit;
    }

    window {
        height: 500px;
        border: 3px;
        border-radius: 6px;
        border-color: @border-col;
        background-color: @bg-col;
    }

    mainbox {
        background-color: @bg-col;
    }

    inputbar {
        children: [prompt,entry];
        background-color: @bg-col;
        border-radius: 5px;
        padding: 2px;
    }

    prompt {
        background-color: @blue;
        padding: 6px;
        text-color: @bg-col;
        border-radius: 3px;
        margin: 20px 0px 0px 20px;
    }

    textbox-prompt-colon {
        expand: false;
        str: ":";
    }

    entry {
        padding: 6px;
        margin: 20px 0px 0px 10px;
        text-color: @fg-col;
        background-color: @bg-col;
    }

    listview {
        border: 0px 0px 0px;
        padding: 6px 0px 0px;
        margin: 10px 0px 0px 20px;
        columns: 2;
        lines: 5;
        background-color: @bg-col;
    }

    element {
        padding: 5px;
        background-color: @bg-col;
        text-color: @fg-col  ;
    }

    element-icon {
        size: 25px;
    }

    element selected {
        background-color:  @selected-col ;
        text-color: @fg-col2  ;
    }

    mode-switcher {
        spacing: 0;
      }

    button {
        padding: 10px;
        background-color: @bg-col-light;
        text-color: @grey;
        vertical-align: 0.5;
        horizontal-align: 0.5;
    }

    button selected {
      background-color: @bg-col;
      text-color: @blue;
    }

    message {
        background-color: @bg-col-light;
        margin: 2px;
        padding: 2px;
        border-radius: 5px;
    }

    textbox {
        padding: 6px;
        margin: 20px 0px 0px 20px;
        text-color: @blue;
        background-color: @bg-col-light;
    }
  '';
}
