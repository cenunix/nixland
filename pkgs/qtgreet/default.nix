{
  stdenv,
  lib,
  fetchFromGitLab,
  ninja,
  meson,
  pkg-config,
  wrapQtAppsHook,
  libxkbcommon,
  pixman,
  qtbase,
  qttools,
  wayqt,
  wayland,
  wlroots_0_16,
  dfapplications,
  dflogin1,
  dfutils,
}:
stdenv.mkDerivation {
  pname = "qtgreet";
  version = "unstable-2023-04-19";

  src = fetchFromGitLab {
    owner = "marcusbritanicus";
    repo = "qtgreet";
    rev = "274e439dc1f2fcf39186f867a7a863269e236244";
    hash = "";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wrapQtAppsHook
  ];

  buildInputs = [
    dfapplications
    dflogin1
    dfutils
    libxkbcommon
    pixman
    qtbase
    qttools
    wayqt
    wayland
    wlroots_0_16
  ];

  mesonFlags = [
    "-Dnodynpath=true"
  ];

  meta = with lib; {
    homepage = "https://gitlab.com/marcusbritanicus/QtGreet";
    description = "Qt based greeter for greetd, to be run under wayfire or similar wlr-based compositors";
    maintainers = with maintainers; [shawn8901];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
