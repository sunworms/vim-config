{
  pkgs,
  vimRcFile,
}:
pkgs.vim-full.customize {
  vimrcConfig.customRC = vimRcFile;
  vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
    start = [
      vimtex
      vim-gitgutter
      vim-sleuth
    ];
    opt = [
      fzf-wrapper
      fzf-vim
      vim-lsp
      asyncomplete-vim
      asyncomplete-lsp-vim
    ];
  };
}
