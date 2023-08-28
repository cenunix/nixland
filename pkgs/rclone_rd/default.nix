{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
, buildPackages
, installShellFiles
, makeWrapper
, enableCmount ? true
, fuse
, fuse3
, macfuse-stubs
, librclone
}:

buildGoModule rec {
  pname = "rclone_RD";
  version = "1.63.1";

  src = fetchFromGitHub {
    owner = "itsToggle";
    repo = pname;
    rev = "869702c7dd46a0a152d397d800a374ce07330e25";
    hash = "sha256-VJPts3cPxofDcPOTuR5dISN/oGjDiDJVy8MkwPnBKTw=";
  };

  vendorHash = "sha256-YdRuSpwVOOk7TYPNUWc3jDcZmCxi7m3J8mVnM0L6sWc=";

  subPackages = [ "." ];

  outputs = [ "out" "man" ];

  buildInputs = lib.optional enableCmount (if stdenv.isDarwin then macfuse-stubs else [ fuse fuse3 ]);
  nativeBuildInputs = [ installShellFiles makeWrapper ];

  tags = lib.optionals enableCmount [ "cmount" ];

  ldflags = [ "-s" "-w" "-X github.com/rclone/rclone/fs.Version=${version}" ];

  postInstall =
    let
      rcloneBin =
        if stdenv.buildPlatform.canExecute stdenv.hostPlatform
        then "$out"
        else lib.getBin buildPackages.rclone;
    in
    ''
      installManPage rclone.1
      for shell in bash zsh fish; do
        ${rcloneBin}/bin/rclone genautocomplete $shell rclone.$shell
        installShellCompletion rclone.$shell
      done
    '' + lib.optionalString (enableCmount && !stdenv.isDarwin)
      # use --suffix here to ensure we don't shadow /run/wrappers/bin/fusermount,
      # as the setuid wrapper is required as non-root on NixOS.
      ''
        wrapProgram $out/bin/rclone \
          --suffix PATH : "${lib.makeBinPath [ fuse fuse3 ] }" \
          --prefix LD_LIBRARY_PATH : "${fuse3}/lib"
      '';

  passthru.tests = {
    inherit librclone;
  };

  meta = with lib; {
    description = "Command line program to sync files and directories to and from major cloud storage";
    homepage = "https://rclone.org";
    changelog = "https://github.com/rclone/rclone/blob/v${version}/docs/content/changelog.md";
    license = licenses.mit;
    maintainers = with maintainers; [ marsam SuperSandro2000 ];
  };
}
