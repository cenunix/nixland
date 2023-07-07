{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
  makeWrapper,
  xsel,
  wl-clipboard,
}:
buildGoModule rec {
  pname = "discordo";
  version = "unstable-2023-04-07";

  src = fetchFromGitHub {
    owner = "ayn2op";
    repo = pname;
    rev = "c8a9c6ecdd1ca25f33c3e09de85048d1b7dd0271";
    hash = "sha256-oHvynN4P6DqSkD+JHSu9Ds5IiCOC0K484xyb4KpdhDA=";
  };

  vendorHash = "sha256-YIQVdG7WXrNIMy8NVpgzL7SaEFWrfNJDm+MeG0/ITfg=";

  CGO_ENABLED = 0;

  ldflags = ["-s" "-w"];

  # Clipboard support on X11 and Wayland
  nativeBuildInputs = [makeWrapper];

  postInstall = ''
    wrapProgram $out/bin/discordo \
      --prefix PATH : ${lib.makeBinPath [xsel wl-clipboard]}
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = ["--version=branch"];
  };

  meta = with lib; {
    description = "A lightweight, secure, and feature-rich Discord terminal client";
    homepage = "https://github.com/ayn2op/discordo";
    license = licenses.mit;
    maintainers = [maintainers.arian-d];
  };
}
