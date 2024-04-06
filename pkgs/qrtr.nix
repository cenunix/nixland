{ lib, stdenv, fetchFromGitHub, systemd, }:
stdenv.mkDerivation {
  pname = "qrtr";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "andersson";
    repo = "qrtr";
    rev = "d0d471c96e7d112fac6f48bd11f9e8ce209c04d2";
    sha256 = "sha256-KF0gCBRw3BDJdK1s+dYhHkokVTHwRFO58ho0IwHPehc=";
  };

  makeFlags = [ "prefix=${placeholder "out"}" ];

  buildInputs = [ systemd ];

  meta = with lib; {
    homepage = "https://github.com/andersson/qrtr";
    description = "qrtr";
    license = licenses.bsd3;
    maintainers = with maintainers; [ cenunix ];
    platforms = platforms.linux;
  };
}
