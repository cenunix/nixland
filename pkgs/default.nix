# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{pkgs ? (import ../nixpkgs.nix) {}}: {
  # x13s packages
  x13s-firmware = pkgs.callPackage ./x13s-firmware.nix {};
  alsa-ucm-conf-x13s = pkgs.callPackage ./alsa-ucm-conf-x13s.nix {};
  # other various packages
  astronvim = pkgs.callPackage ./astronvim/default.nix {};
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors.nix {};
  grimblast = pkgs.callPackage ./grimblast/default.nix {};
  air-status = pkgs.callPackage ./air-status.nix {};
  discordo = pkgs.callPackage ./discordo.nix {};
  gg-sans = pkgs.callPackage ./gg-sans {};
}
