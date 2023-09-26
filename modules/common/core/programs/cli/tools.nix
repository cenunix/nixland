{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  environment.systemPackages = with pkgs; [
    unzip
    ripgrep
    nmap
    fd
    xh
    jq
    fzf
    p7zip
    grex
    lm_sensors
    dua
    vim
<<<<<<< HEAD
    woeusb
    cargo
    rustc
    gcc
||||||| parent of 3aa6b96 (update mediaserver.nix)
    woeusb
=======
    cargo
    rustc
    gcc
    python311Packages.pip
>>>>>>> 3aa6b96 (update mediaserver.nix)
  ];
}
