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
<<<<<<< HEAD
    woeusb
||||||| parent of bb9fd4f (update)
    woeusb
=======
>>>>>>> bb9fd4f (update)
    cargo
    rustc
    gcc
<<<<<<< HEAD
||||||| parent of 3aa6b96 (update mediaserver.nix)
    woeusb
=======
    cargo
    rustc
    gcc
    python311Packages.pip
>>>>>>> 3aa6b96 (update mediaserver.nix)
||||||| parent of bb9fd4f (update)
=======
    python311Packages.pip
>>>>>>> bb9fd4f (update)
  ];
}
