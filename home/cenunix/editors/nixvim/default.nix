{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
# let
#   nvim = inputs.nixvim.legacyPackages."${pkgs.system}".makeNixvimWithModule {
#     inherit pkgs;
#     module = import ./config;
#   };
# in
{
  config = {
    users.users.cenunix.packages = with pkgs; [
      (pkgs.callPackage ../../../../pkgs/nvim {inherit inputs;})
      deadnix
      statix
      nil
      alejandra
    ];
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    programs.zsh.shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };
}
