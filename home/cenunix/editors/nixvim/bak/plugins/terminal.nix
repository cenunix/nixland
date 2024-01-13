{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    # maps.normal."<F7>" = {
    #   action = "<cmd>ToggleTerm direction=float<CR>";
    #   silent = true;
    #   desc = "ToggleTerm Float";
    # };
    # maps.terminal."<F7>" = {
    #   action = "<cmd>ToggleTerm direction=float<CR>";
    #   silent = true;
    #   desc = "ToggleTerm Float";
    # };
    plugins = {
      toggleterm.enable = true;
    };
  };
}
