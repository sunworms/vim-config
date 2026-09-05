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
      vim-gitgutter
    ];
    opt = [
      vim-lsp
      asyncomplete-vim
      asyncomplete-lsp-vim
    ];
  };
}
