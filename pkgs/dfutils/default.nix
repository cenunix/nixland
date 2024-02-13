{
  stdenv,
  lib,
  fetchFromGitLab,
  meson,
  pkg-config,
  cmake,
  ninja,
  qtbase,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "dfutils";
  version = "unstable-2023-01-23";

  src = fetchFromGitLab {
    owner = "desktop-frameworks";
    repo = "utils";
    rev = "dc97a675b79b95b60b9bfb803cb300b1b38e9764";
    hash = "sha256-IxWYxQP9y51XbZAR+VOex/GYZblAWs8KmoaoFvU0rCY=";
  };

  nativeBuildInputs = [
    meson
    pkg-config
    ninja
    cmake
  ];

  buildInputs = [
    qtbase
  ];

  dontWrapQtApps = true;

  meta = with lib; {
    homepage = "https://gitlab.com/desktop-frameworks/utils";
    description = "Some utilities for DFL";
    maintainers = with maintainers; [shawn8901];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
})
