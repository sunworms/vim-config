{
  pkgs,
  vimRcFile,
}:
pkgs.vim-full.customize {
  vimrcConfig.customRC = builtins.readFile vimRcFile;
  vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
    start = [
      ctrlp-vim
      vimtex
    ];
    opt = [
      vim-lsp
      asyncomplete-vim
      asyncomplete-lsp-vim
    ];
  };
}
