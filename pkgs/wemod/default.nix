{ lib, fetchFromGitHub, stdenv, python3Packages, python311Packages, python3, tk
, protonup-qt, }:
let
  FreeSimpleGUI = python3Packages.buildPythonApplication rec {
    pname = "FreeSimpleGui";
    version = "5.1.0";

    src = fetchFromGitHub {
      owner = "spyoungtech";
      repo = "FreeSimpleGUI";
      rev = "v${version}";
      sha256 = "sha256-kUHuC5tHEd6SUIbNrad8B2BDGHyHYIfjJqWoLM4r1Bk=";
    };
    propagatedBuildInputs = with python3Packages;
      [ pkgs.python311Packages.tkinter ];
  };
in python3.pkgs.buildPythonPackage rec {
  pname = "wemod";
  version = "unstable";
  env = {
    STEAM_COMPAT_DATA_PATH = "\${HOME}/.steam/root/compatibilitytools.d";
  };
  src = ./src;
  wrapProgram = [ python311Packages.sh ];
  propagatedBuildInputs = [
    FreeSimpleGUI
    # python3
    tk
    protonup-qt
    # python3Packages.pip
    # python3Packages.virtualenv
    python3Packages.numpy
    python3Packages.requests
    python311Packages.sh
  ];

  meta = with lib; {
    description = "wemod packaged in nix";
    homepage =
      "https://github.com/daniash551/wemod-launcher?tab=readme-ov-file";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ cenunix ];
    mainProgram = "wemod";
    platforms = platforms.linux;
  };
}
