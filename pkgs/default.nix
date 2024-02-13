# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{pkgs ? (import ../nixpkgs.nix) {}}: {
  # x13s packages
  x13s-firmware = pkgs.callPackage ./x13s-firmware.nix {};
  alsa-ucm-conf-x13s = pkgs.callPackage ./alsa-ucm-conf-x13s.nix {};
  linux_x13s_pkg = pkgs.callPackage ./linux-x13s/default.nix {};
  # other various packages
  qtgreet = pkgs.callPackage ./qtgreet {};
  dfapplications = pkgs.callPackage ./dfapplications {};
  dflogin1 = pkgs.callPackage ./dflogin1 {};
  dfutils = pkgs.callPackage ./dfutils {};
  dfipc = pkgs.callPackage ./dfipc {};
  wayqt = pkgs.callPackage ./wayqt {};
  custom-gtk = pkgs.callPackage ./custom-gtk {};
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors.nix {};
  grimblast = pkgs.callPackage ./grimblast/default.nix {};
  air-status = pkgs.callPackage ./air-status.nix {};
  gg-sans = pkgs.callPackage ./gg-sans {};
  my-webcord = pkgs.callPackage ./webcord/default.nix {};
}
