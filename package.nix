{
  pkgs,
  vimRcFile,
}:
pkgs.vim-full.customize {
  vimrcConfig.customRC = builtins.readFile vimRcFile;
  vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
    start = [
      vim-lsp
      ctrlp-vim
      asyncomplete-vim
      asyncomplete-lsp-vim
      vimtex
    ];
    opt = [];
  };
}
