{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-sddm-corners";
  version = "unstable-2023-02-17";

  src = fetchFromGitHub {
    owner = "cenunix";
    repo = "catppuccin-sddm-corners";
    rev = "7ee8d03dedea9138ab74feae3e5c341ee2f3f9e5";
    hash = "sha256-WF/O/sLpBMB+D1oC0XeMIodQnADIMrctXlt4LyaJi60=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/sddm/themes/"
    cp -r catppuccin/ "$out/share/sddm/themes/catppuccin-sddm-corners"

    runHook postInstall
  '';

  meta = {
    description = "Soothing pastel theme for SDDM based on corners theme.";
    homepage = "https://github.com/khaneliman/sddm-catppuccin-corners";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [khaneliman];
    platforms = lib.platforms.linux;
  };
}
