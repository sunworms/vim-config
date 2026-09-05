if filereadable(expand('~/.cache/noctalia/colors.vim'))
    source ~/.cache/noctalia/colors.vim
endif

autocmd FileType nix highlight link LspSemanticVariable Identifier
autocmd FileType nix highlight link LspSemanticProperty Type
autocmd FileType nix highlight link LspSemanticParameter Label
autocmd FileType nix highlight link LspSemanticEvent PreProc
