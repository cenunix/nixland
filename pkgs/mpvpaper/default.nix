#f65700a3ecc9ecd8ca501e18a807ee18845f9441
{ stdenv
, lib
, meson
, ninja
, wlroots
, wayland
, wayland-protocols
, wayland-scanner
, egl-wayland
, glew-egl
, mpv
, pkg-config
, fetchFromGitHub
, makeWrapper
, installShellFiles
}:

stdenv.mkDerivation rec {
  pname = "mpvpaper";
  version = "f65700a3ecc9ecd8ca501e18a807ee18845f9441";

  src = fetchFromGitHub {
    owner = "GhostNaN";
    repo = pname;
    rev = "f65700a3ecc9ecd8ca501e18a807ee18845f9441";
    sha256 = "sha256-h+YJ4YGVGGgInVgm3NbXQIbrxkMOD/HtBnCzkTcRXH8=";
  };

  strictDeps = true;
  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    makeWrapper
    installShellFiles
    wayland-scanner
  ];

  buildInputs = [
    wlroots
    wayland
    wayland-protocols
    egl-wayland
    glew-egl
    mpv
  ];

  preInstall = ''
    mv ../mpvpaper.man ../mpvpaper.1
  '';

  postInstall = ''
    wrapProgram $out/bin/mpvpaper \
      --prefix PATH : ${lib.makeBinPath [ mpv ]}

    installManPage ../mpvpaper.1
  '';

  meta = with lib; {
    description = "A video wallpaper program for wlroots based wayland compositors";
    homepage = "https://github.com/GhostNaN/mpvpaper";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    mainProgram = "mpvpaper";
    maintainers = with maintainers; [ atila ];
  };
}
