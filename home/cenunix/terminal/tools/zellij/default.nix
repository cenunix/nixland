{ config, osConfig, inputs, pkgs, ... }: {

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = { defaultSession = "tmux"; };
  };
}
