# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{pkgs ? (import ../nixpkgs.nix) {}}: {
  x13s-firmware = pkgs.callPackage ./x13s-firmware.nix {};
  alsa-ucm-conf-x13s = pkgs.callPackage ./alsa-ucm-conf-x13s.nix {};
  # alsa-lib = pkgs.callPackage ./alsa-lib.nix {};

  astronvim = pkgs.callPackage ./astronvim/default.nix {};
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors.nix {};
  catppuccin-folders = pkgs.callPackage ./catppuccin-folders.nix {};
  grimblast = pkgs.callPackage ./grimblast/default.nix {};
  air-status = pkgs.callPackage ./air-status.nix {};
  discordo = pkgs.callPackage ./discordo.nix {};
}
