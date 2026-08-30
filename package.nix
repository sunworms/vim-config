{
  pkgs,
  vimRcFile,
}:
pkgs.vim-full.customize {
  vimrcConfig.customRC = vimRcFile;
  vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
    start = [
      fzf-vim
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
