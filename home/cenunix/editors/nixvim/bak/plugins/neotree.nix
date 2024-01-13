{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  config = {
    plugins = {
      neo-tree = {
        enable = true;
      };
    };
    extraConfigLua = ''
      require("neo-tree").setup({
      		window = {
          position = "float",
      		 mappings = {
      		  ["<space>"] = false,
      		 },
      	  },
      })
    '';
  };
}
