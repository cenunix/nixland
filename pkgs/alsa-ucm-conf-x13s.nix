{ lib
, stdenv
, fetchFromGitHub
,
}:
stdenv.mkDerivation rec {
  pname = "alsa-ucm-conf";
  version = "1.2.10";

  src = fetchFromGitHub {
    owner = "Srinivas-Kandagatla";
    repo = "alsa-ucm-conf";
    rev = "e8c3e7792336e9f68aa560db8ad19ba06ba786bb";
    sha256 = "sha256-4fIvgHIkTyGApM3uvucFPSYMMGYR5vjHOz6KQ26Kg7A=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/alsa
    cp -av ucm2 $out/share/alsa

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
    maintainers = [ maintainers.roastiek ];
    platforms = platforms.linux;
  };
}
