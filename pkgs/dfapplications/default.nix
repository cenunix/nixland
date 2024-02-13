{
  stdenv,
  lib,
  fetchFromGitLab,
  meson,
  pkg-config,
  cmake,
  ninja,
  qtbase,
  wayland,
  dfipc,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "dfapplications";
  version = "unstable-2023-02-09";

  src = fetchFromGitLab {
    owner = "desktop-frameworks";
    repo = "applications";
    rev = "19291975c84a65a6abaf23ff8a7dd50239e6cde5";
    hash = "sha256-Q5xt9M4VoJpd756GiHfbto73y3OuDCjdDSdfCK0mzEk=";
  };

  nativeBuildInputs = [
    meson
    pkg-config
    ninja
  ];

  buildInputs = [
    qtbase
  ];

  propagatedBuildInputs = [
    dfipc
  ];

  dontWrapQtApps = true;

  meta = with lib; {
    homepage = "https://gitlab.com/desktop-frameworks/applications";
    maintainers = with maintainers; [shawn8901];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
})
