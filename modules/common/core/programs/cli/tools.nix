{ inputs, outputs, lib, config, pkgs, ... }: {
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
    gnome.zenity
    nix-prefetch-github
  ];
}
