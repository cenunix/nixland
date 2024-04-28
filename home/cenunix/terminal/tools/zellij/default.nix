{ config, osConfig, inputs, pkgs, ... }: {

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      # simplified_ui = true;
      pane_frames = false;
      # default_layout = "compact";
      ui.pane_frames.rounded_corners = true;
    };
  };
}
