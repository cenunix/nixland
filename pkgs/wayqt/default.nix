{
  stdenv,
  lib,
  fetchFromGitLab,
  meson,
  pkg-config,
  cmake,
  ninja,
  libxkbcommon,
  libGL,
  libpng,
  qt5,
  wayland,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "wayqt";
  version = "0.2.0";

  src = fetchFromGitLab {
    owner = "desktop-frameworks";
    repo = "wayqt";
    rev = "2f240620b9752ef58b8eba5eaa8e13396aef438b";
    hash = "sha256-i1KZp6y8/jtLnZmXSMAT3wbYY/yuZKTX0Lk6HC1Pnio=";
  };

  nativeBuildInputs = [
    meson
    pkg-config
    cmake
    ninja
  ];

  buildInputs = [
    qt5.full
    libGL
    libpng
    libxkbcommon
    wayland
  ];

  dontWrapQtApps = true;

  meta = with lib; {
    homepage = "https://gitlab.com/desktop-frameworks/wayqt";
    description = "A Qt-based wrapper for various wayland protocols.";
    maintainers = with maintainers; [shawn8901];
    platforms = platforms.linux;
    license = licenses.mit;
  };
})
