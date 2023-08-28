{ lib
, stdenv
, fetchurl
, fuse3
, systemd
,
}:
stdenv.mkDerivation {
  pname = "rclone_rd";
  version = "v1.58.1-rd.2.2";

  src = fetchurl {
    url = "https://github.com/itsToggle/rclone_RD/releases/download/v1.58.1-rd.2.2/z-rclone-as-beta-linux";
    sha256 = "sha256-f+6H+F7p4jWNqf3qb36HXOtJZ5ixLJFA/ZqAH6iJkyU=";
  };
  buildInputs = [
    fuse3
  ];
  phases = [ "buildPhase" "installPhase" "patchPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/rclone-linux
    chmod +x $out/bin/rclone-linux
  '';
}
