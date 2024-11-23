{ config, lib, osConfig, ... }:
let inherit (lib) mkForce;
in {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = mkForce "Maple Mono SC NF:size=20";
        icon-theme = "Papirus-Dark";
        prompt = "'   '";
        match-counter = true;
        lines = 8;
        line-height = 50;
        inner-pad = 5;
        horizontal-pad = 13;
        show-actions = true;
        terminal = "foot";
      };

      colors = {
        match = mkForce "#70707bff";
        selection-match = mkForce "#07070bff";
      };

      key-bindings = {
        execute-or-next = "none";
        cursor-left = "Left Control+h";
        cursor-left-word = "Control+Left Mod1+h";
        cursor-right = "Right Control+l";
        cursor-right-word = "Control+Right Mod1+l";
        delete-line-forward = "none";
        prev = "none";
        prev-with-wrap = "Up Control+k ISO_Left_Tab";
        next = "none";
        next-with-wrap = "Down Control+j Tab";
        cancel = "Escape Control+c";
        cursor-home = "Control+a";
        cursor-end = "Control+e";
        first = "Home Control+g";
        last = "End Control+Shift+g";
        delete-prev = "BackSpace";
      };
    };
  };
}
