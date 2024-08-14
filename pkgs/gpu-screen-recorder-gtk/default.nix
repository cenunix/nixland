{ stdenv, lib, fetchGit, pkg-config, desktop-file-utils, makeWrapper, meson
, ninja, gtk3, libayatana-appindicator, libpulseaudio, libdrm
, gpu-screen-recorder, libglvnd, libX11, libXrandr, wayland, wrapGAppsHook3
, wrapperDir ? "/run/wrappers/bin" }:

stdenv.mkDerivation {
  pname = "gpu-screen-recorder-gtk";
  version = "unstable-2024-08-10";

  # Snapshot tarballs use the following versioning format:
  # printf "r%s.%s\n" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
  src = fetchGit {
    url = "https://repo.dec05eba.com/gpu-screen-recorder";
    rev = "261d0a06602d345257c8abd4c7a67f4e81172b81";
    sha256 = "sha256-86EdmeZ2dlffSfJOrTVGPtYyL3j6DmCQIALX2rpeS1Y=";
  };
  sourceRoot = ".";

  nativeBuildInputs =
    [ desktop-file-utils pkg-config makeWrapper meson ninja wrapGAppsHook3 ];

  buildInputs = [
    gtk3
    libayatana-appindicator
    libpulseaudio
    libdrm
    libX11
    libXrandr
    wayland
  ];

  preFixup = let
    gpu-screen-recorder-wrapped =
      gpu-screen-recorder.override { inherit wrapperDir; };
  in ''
    gappsWrapperArgs+=(--prefix PATH : ${wrapperDir})
    gappsWrapperArgs+=(--suffix PATH : ${
      lib.makeBinPath [ gpu-screen-recorder-wrapped ]
    })
    # we also append /run/opengl-driver/lib as it otherwise fails to find libcuda.
    gappsWrapperArgs+=(--prefix LD_LIBRARY_PATH : ${
      lib.makeLibraryPath [ libglvnd ]
    }:/run/opengl-driver/lib)
  '';

  meta = {
    description = "GTK frontend for gpu-screen-recorder.";
    mainProgram = "gpu-screen-recorder-gtk";
    homepage = "https://git.dec05eba.com/gpu-screen-recorder-gtk/about/";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ babbaj ];
    platforms = [ "x86_64-linux" ];
  };
}
