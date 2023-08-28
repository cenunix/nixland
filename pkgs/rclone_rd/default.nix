{ lib
, stdenv
, fetchUrl
, systemd
,
}:
stdenv.mkDerivation {
  pname = "rclone_rd";
  version = "1.0";

  src = fetchUrl {
    url = "https://github.com/itsToggle/rclone_RD/releases/download/v1.58.1-rd.2.2/rclone-linux";
    sha256 = "sha256-KF0gCBRw3BDJdK1s+dYhHkokVTHwRFO58ho0IwHPehc=";
  };
  phases = [ "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/rclone-linux
    chmod +x $out/bin/rclone-linux
  '';
}
