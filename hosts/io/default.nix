{
  imports = [
    ./configuration.nix
  ];

  networking = {
    hostName = "io";
  };
  system.stateVersion = "23.05";
}
