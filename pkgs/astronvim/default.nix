{ lib
, stdenv
, pkgs
,
}:
let
  user = ./user;
in
stdenv.mkDerivation {
  pname = "astronvim";
  version = "2.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "4c443fbc83534a9efdc32d4ef8e37d37bb884835";
    # rev = "32b0a008a96a3dd04675659e45a676b639236a98";
    # sha256 = "sha256-s/nnGUGFgJ+gpMAOO3hYJ6PrX/qti6U1wyB6PzTiNtM=";
    sha256 = "sha256-cyZYnLGcLOnHdv3D4OsqO9hI+hEbmNzb3pQG+OiYCUQ=";
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
    maintainers = [ maintainers.cenunix ];
    license = licenses.gpl3;
  };
}
