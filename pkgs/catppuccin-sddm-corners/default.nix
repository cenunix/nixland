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
    rev = "79db4dd0610e3a0b72e12e8996e1aee6b6194347";
    hash = "sha256-xA8/wpoLGz4affdZAqsr8qnUTOabQ6m24vh+TLQi7TA=";
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
