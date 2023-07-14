{
  lib,
  stdenv,
  pkgs,
}:
stdenv.mkDerivation {
  pname = "lazyvim";
  version = "5.0.0";

  src = ./LazyVim;

  # src = ./ttf;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r * $out

    runHook postInstall
  '';

  meta = with lib; {
    description = "LazyVim";
    homepage = "https://github.com/LazyVim/LazyVim";
    platforms = platforms.all;
    maintainers = [maintainers.cenunix];
    license = licenses.gpl3;
  };
}
