{
  pkgs,
  vimRcFile,
}:
pkgs.vim-full.customize {
  vimrcConfig.customRC = vimRcFile;
  vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
    start = [
      ctrlp-vim
      vimtex
      vim-signify
    ];
    opt = [
      vim-lsp
      asyncomplete-vim
      asyncomplete-lsp-vim
    ];
  };
}
