

{ lib, addOpenGLRunpath, dbus, ffmpeg, libdrm, libglvnd, libpulseaudio, libva
, makeWrapper, meson, ninja, pipewire, pkg-config, stdenv, fetchurl, wayland
, xorg, ... }:
let
  inherit (lib) makeLibraryPath;
  inherit (builtins) fromTOML readFile;

  # tag = (fromTOML
  #   (readFile "${gpu-screen-recorder-src}/project.conf")).package.version;
in stdenv.mkDerivation {
  pname = "gpu-screen-recorder";
  version = "01b8cdc";

  src = fetchurl {
    url =
      "https://dec05eba.com/snapshot/gpu-screen-recorder.git.r717.01b8cdc.tar.gz";
    hash = "sha256-SNhLpXFXN36SsXDnoP8S+yj8eOhi4qRFy4ZSkt4UQSw=";
  };
  sourceRoot = ".";
  nativeBuildInputs = [ pkg-config makeWrapper meson ninja ];

  buildInputs = [
    dbus
    libpulseaudio
    pipewire
    ffmpeg
    wayland
    libdrm
    libva
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXi
    xorg.libXrandr
  ];

  mesonFlags =
    [ "-Dcapabilities=false" "-Dnvidia_suspend_fix=false" "-Dsystemd=false" ];

  fixupPhase = ''
    wrapProgram $out/bin/gpu-screen-recorder \
      --prefix LD_LIBRARY_PATH : "${
        makeLibraryPath [ addOpenGLRunpath.driverLink libglvnd ]
      }"
  '';

  meta = {
    description =
      "Screen recorder that has minimal impact on system performance by recording a window using the GPU only";
    homepage = "https://git.dec05eba.com/gpu-screen-recorder/about/";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
  };
}
