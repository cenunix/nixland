{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
<<<<<<< Updated upstream
||||||| Stash base
    ./nixvim
=======
    ./nvim
>>>>>>> Stashed changes
    ./vscode
    ./helix
  ];
}
