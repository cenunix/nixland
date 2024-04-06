{ lib, stdenv, fetchFromGitHub, makeWrapper, bluez, }:
stdenv.mkDerivation (finalAttrs: {
  pname = "wofi-bluetooth";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "arpn";
    repo = "wofi-bluetooth";
    rev = "722dc554c7a9515bca1cc646d226f65883f9343f";
    sha256 = "sha256-g8Zg8TCqHFDIjHU/0lJ9qLdEFHeWvohzgyBPHvG7Sng=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -D --target-directory=$out/bin/ ./wofi-bluetooth

    wrapProgram $out/bin/wofi-bluetooth \
      --prefix PATH ":" ${lib.makeBinPath [ bluez ]}

    runHook postInstall
  '';

  meta = with lib; {
    description =
      "Wofi-based interface to connect to bluetooth devices and display status info";
    homepage = "https://github.com/nickclyde/wofi-bluetooth";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ cenunix ];
    mainProgram = "wofi-bluetooth";
    platforms = platforms.linux;
  };
})
