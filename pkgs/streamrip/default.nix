{ lib, fetchFromGitHub, fetchPypi, ffmpeg, fzf, mpv, python3 }:

let
  pname = "streamrip";
  version = "2.0.5 ";
in python3.pkgs.buildPythonPackage {
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "";
  };
}
