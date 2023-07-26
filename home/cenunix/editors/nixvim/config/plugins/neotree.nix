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
        sources = [
          "filesystem"
          "buffers"
          "git_status"
        ];
        closeIfLastWindow = true;
        sourceSelector = {
          winbar = true;
          contentLayout = "start";
          sources = [
          ];
        };
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
