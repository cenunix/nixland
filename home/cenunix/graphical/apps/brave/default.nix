{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "lljedihjnnjjefafchaljkhbpfhfkdic";} # jiffy reader
      {id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";} # catppuccin
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # sponsorblock
      {id = "haebnnbpedcbhciplfhjjkbafijpncjl";} # tineye
      {id = "gebbhagfogifgggkldgodflihgfeippi";} # yt dislike
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
    ];
  };
}
