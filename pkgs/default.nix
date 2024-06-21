# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{ pkgs ? (import ../nixpkgs.nix) { } }: rec {
  # x13s packages
  x13s-firmware = pkgs.callPackage ./x13s-firmware.nix { };
  alsa-ucm-conf-x13s = pkgs.callPackage ./alsa-ucm-conf-x13s.nix { };
  linux_x13s_pkg = pkgs.callPackage ./linux-x13s/default.nix { };
  # other various packages
  pythcat = pkgs.python3Packages.callPackage ./pythcatppuccin { };
  custom-gtk = pkgs.callPackage ./custom-gtk { inherit pythcat; };
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors.nix { };
  gg-sans = pkgs.callPackage ./gg-sans { };
  my-webcord = pkgs.callPackage ./webcord/default.nix { };
  # wofi-bluetooth = pkgs.callPackage ./wofi-bluetooth/default.nix { };
  streamrip = pkgs.callPackage ./streamrip { };
  # my-vesktop = pkgs.callPackage ./vesktop { };
  owo-vencord = pkgs.callPacakge ./owo-vencord { };
  nheko = pkgs.callPackage ./nheko { };
}
