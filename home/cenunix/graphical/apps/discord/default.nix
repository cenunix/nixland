{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, self
, ...
}:
{
  home.packages = with pkgs; [
    (pkgs.discord.override {
      # remove any overrides that you don't want
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
