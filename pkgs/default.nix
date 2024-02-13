# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{pkgs ? (import ../nixpkgs.nix) {}}: rec {
  # x13s packages
  x13s-firmware = pkgs.callPackage ./x13s-firmware.nix {};
  alsa-ucm-conf-x13s = pkgs.callPackage ./alsa-ucm-conf-x13s.nix {};
  linux_x13s_pkg = pkgs.callPackage ./linux-x13s/default.nix {};
  # other various packages
  custom-gtk = pkgs.callPackage ./custom-gtk {};
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors.nix {};
  grimblast = pkgs.callPackage ./grimblast/default.nix {};
  air-status = pkgs.callPackage ./air-status.nix {};
  gg-sans = pkgs.callPackage ./gg-sans {};
  my-webcord = pkgs.callPackage ./webcord/default.nix {};
  dfipc = pkgs.libsForQt5.callPackage ./dfipc {};
  dflogin1 = pkgs.libsForQt5.callPackage ./dflogin1 {};
  dfutils = pkgs.libsForQt5.callPackage ./dfutils {};
  dfapplications = pkgs.libsForQt5.callPackage ./dfapplications {inherit dfipc;};
  qtgreet = pkgs.libsForQt5.callPackage ./qtgreet {inherit wayqt dfapplications dfutils dflogin1;};
  wayqt = pkgs.libsForQt5.callPackage ./wayqt {};
  sddm-aerial-theme = pkgs.callPackage ./sddm-aerial {};
}
