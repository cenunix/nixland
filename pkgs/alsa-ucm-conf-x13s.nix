{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "alsa-ucm-conf-x13s";
  version = "1.2.9";

  src = fetchFromGitHub {
    owner = "cenunix";
    repo = "alsa-ucm-conf";
    rev = "c30fda1f8549a18c30fe283b97a6228acb27978d";
    # rev = "32b0a008a96a3dd04675659e45a676b639236a98";
    # sha256 = "sha256-s/nnGUGFgJ+gpMAOO3hYJ6PrX/qti6U1wyB6PzTiNtM=";
    sha256 = "sha256-3jgU9Hg+CzU28VMSRnH2ky0VDpntCHkclK/caSCZYRE=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/alsa
    cp -r ucm ucm2 $out/share/alsa

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.alsa-project.org/";
    description = "ALSA Use Case Manager configuration";

    longDescription = ''
      The Advanced Linux Sound Architecture (ALSA) provides audio and
      MIDI functionality to the Linux-based operating system.
    '';

    license = licenses.bsd3;
    maintainers = [maintainers.roastiek];
    platforms = platforms.linux;
  };
}
