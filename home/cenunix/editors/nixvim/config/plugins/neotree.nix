{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    plugins = {
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
      };
    };
    extraConfigLua = ''
      require("neo-tree").setup({
      		window = {
      		 mappings = {
      		  ["<space>"] = false,
      		 },
      		},
      		})
    '';
  };
}
