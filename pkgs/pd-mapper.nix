{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  qrtr,
}:
stdenv.mkDerivation {
  pname = "pd-mapper";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "cenunix";
    repo = "pd-mapper";
    rev = "63bf07ce75c23396bad9bb0391c3a60fad81a9bc";
    sha256 = "sha256-/doESH6TL9CyA7bCr8LVwkGe8dikfvaGTmxtszXvDQ8=";
  };

  nativeBuildInputs = [pkg-config];
  buildInputs = [qrtr];

  makeFlags = [
    "CC=${stdenv.cc.targetPrefix}cc"
    "prefix=${placeholder "out"}"
  ];

  meta = with lib; {
    homepage = "https://github.com/andersson/pd-mapper";
    description = "pd-mapper";
    license = licenses.bsd3;
    maintainers = with maintainers; [cenunix];
    platforms = platforms.linux;
  };
}
