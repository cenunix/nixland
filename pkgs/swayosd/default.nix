{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, wrapGAppsHook
, cargo
, coreutils
, gtk-layer-shell
, libevdev
, libinput
, libpulseaudio
, meson
, ninja
, rustc
, stdenv
, udev
}:

stdenv.mkDerivation rec {
  pname = "swayosd";
  version = "unstable-2023-07-18";

  src = fetchFromGitHub {
    owner = "ErikReider";
    repo = "SwayOSD";
    rev = "1c7d2f5b3ee262f25bdd3c899eadf17efb656d26";
    hash = "";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-pExpzQwuHREhgkj+eZ8drBVsh/B3WiQBBh906O6ymFw=";
  };

  nativeBuildInputs = [
    wrapGAppsHook
    pkg-config
    meson
    rustc
    cargo
    ninja
    rustPlatform.cargoSetupHook
  ];

  buildInputs = [
    gtk-layer-shell
    libevdev
    libinput
    libpulseaudio
    udev
  ];

  patches = [
    ./swayosd_systemd_paths.patch
  ];

  postPatch = ''
    substituteInPlace data/udev/99-swayosd.rules \
      --replace /bin/chgrp ${coreutils}/bin/chgrp \
      --replace /bin/chmod ${coreutils}/bin/chmod
  '';

  meta = with lib; {
    description = "A GTK based on screen display for keyboard shortcuts";
    homepage = "https://github.com/ErikReider/SwayOSD";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ aleksana ];
    platforms = platforms.linux;
  };
}
