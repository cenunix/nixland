{
  imports = [ ./configuration.nix ];

  networking = { hostName = "callisto"; };
  system.stateVersion = "23.05";
}
