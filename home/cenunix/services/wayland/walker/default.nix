{ inputs, outputs, lib, config, pkgs, self, ... }: {
  imports = [ inputs.walker.homeManagerModules.default ];
  programs.walker = {
    enable = true;
    runAsService = true;
  };
}
