{
  imports = [
    ./configuration.nix
  ];

  networking = {
    hostName = "exht";
  };
  system.stateVersion = "23.05";
}
