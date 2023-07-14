{
  lib,
  stdenv,
  pkgs,
}: let
  nvim = ./nvim;
in
  stdenv.mkDerivation {
    pname = "lazyvim";
    version = "5.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "LazyVim";
      repo = "LazyVim";
      rev = "8c0e39c826f697d668aae336ea26a83be806a543";
      sha256 = "sha256-oOUHGG3SQ9l/+YQhSOpoKq26AEzTurm+kMjZQs6Adh4=";
    };

    installPhase = ''
      mkdir $out
      cp -r * "$out/"
      mkdir -p "$out/nvim"
      cp -r ${nvim}/* "$out/nvim/"
    '';

    meta = with lib; {
      description = "AstroNvim";
      homepage = "https://github.com/LazyVim/LazyVim";
      platforms = platforms.all;
      maintainers = [maintainers.cenunix];
      license = licenses.gpl3;
    };
  }
