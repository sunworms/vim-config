if filereadable(expand('~/.cache/noctalia/colors.vim'))
    source ~/.cache/noctalia/colors.vim
endif

autocmd SigUSR1 * source ~/.cache/noctalia/colors.vim
