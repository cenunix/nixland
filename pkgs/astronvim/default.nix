{
  lib,
  stdenv,
  pkgs,
}: let
  user = ./user;
in
  stdenv.mkDerivation {
    pname = "astronvim";
    version = "2.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "AstroNvim";
      repo = "AstroNvim";
      rev = "219e1c7050f27e930f24a156c7c9394bb4c181ce";
      # rev = "32b0a008a96a3dd04675659e45a676b639236a98";
      # sha256 = "sha256-s/nnGUGFgJ+gpMAOO3hYJ6PrX/qti6U1wyB6PzTiNtM=";
      sha256 = "sha256-5ypBVNhkJLVQMeRlHUb3llbJbJGwxbFme6M1XyMH3V8=";
    };

    installPhase = ''
      mkdir $out
      cp -r * "$out/"
      mkdir -p "$out/lua/user"
      cp -r ${user}/* "$out/lua/user/"
    '';

    meta = with lib; {
      description = "AstroNvim";
      homepage = "https://github.com/AstroNvim/AstroNvim";
      platforms = platforms.all;
      maintainers = [maintainers.rayandrew];
      license = licenses.gpl3;
    };
  }
