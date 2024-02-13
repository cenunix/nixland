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
  wlroots,
  dfapplications,
  dflogin1,
  dfutils,
  mpv,
}:
stdenv.mkDerivation {
  pname = "qtgreet";
  version = "unstable-2023-04-19";

  src = fetchFromGitLab {
    owner = "marcusbritanicus";
    repo = "qtgreet";
    rev = "274e439dc1f2fcf39186f867a7a863269e236244";
    hash = "sha256-Lm7OdB9/o7BltPusuxTIuPQ4w23rCIKugEsjGR5vgVg=";
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
    mpv
    libxkbcommon
    pixman
    qtbase
    qttools
    wayqt
    wayland
    wlroots
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
