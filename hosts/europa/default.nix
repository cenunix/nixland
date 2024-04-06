{
  imports = [ ./configuration.nix ];

  networking = { hostName = "europa"; };
  system.stateVersion = "23.05";
}
