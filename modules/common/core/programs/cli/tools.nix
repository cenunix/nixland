{ inputs, outputs, lib, config, pkgs, ... }: {
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    # tools
    unzip
    ripgrep
    fd
    xh
    jq
    fzf
    p7zip
    grex
    lm_sensors
    dua
    unrar
    powertop
    nh
    file
    wget
    zenity
    nix-prefetch-github
    graphviz
    nix-du
  ];
}
