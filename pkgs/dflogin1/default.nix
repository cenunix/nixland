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
  pname = "dflogin1";
  version = "unstable-2023-02-24";

  src = fetchFromGitLab {
    owner = "desktop-frameworks";
    repo = "login1";
    rev = "07a069daf1bf8af58cea220271146e21bea34321";
    hash = "sha256-7URHVc0082LuzteSXAK1nE7vcArrsxaHG1LCV/RvTm4=";
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
    description = "Implementation of systemd/elogind for DFL";
    maintainers = with maintainers; [shawn8901];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
})
