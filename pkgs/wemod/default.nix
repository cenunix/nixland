{ lib, buildPythonPackage, fetchFromGitHub, stdenv, poetry-core
, poetry-dynamic-versioning, pygments, rich, python3Packages, python3, tk
, protonup-qt, pytestCheckHook }:
let
  FreeSimpleGUI = buildPythonPackage rec {
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
in stdenv.mkDerivation (finalAttrs: {
  pname = "wemod";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "DaniAsh551";
    repo = "wemod-launcher";
    rev = "db0254b9285e0d8c4c9692b505047f580ff5e816";
    sha256 = "sha256-zHFoJqhuPk3T9PwGIHRHdrW1Zc/MVSURsfGQuseg/8g=";
  };

  nativeBuildInputs = [
    FreeSimpleGUI
    python3
    tk
    protonup-qt
    python3Packages.pip
    python3Packages.virtualenv

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
})
