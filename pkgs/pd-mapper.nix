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
    rev = "8db3b693572016f986639eb2e2976b5ab3766409";
    sha256 = "sha256-wWIGXWrZ9ajvcW4JR3MBq4jYWNwGKf7s9GarYYvrXzQ=";
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
