autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

let g:vimtex_view_method = 'zathura'
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 200

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>

inoremap {<CR> {<CR>}<Esc>O

autocmd FileType nix setlocal formatprg=alejandra\ --quiet
autocmd FileType typst setlocal formatprg=typstyle

autocmd BufWritePre *.nix normal! gggqG``
autocmd BufWritePre *.typ normal! gggqG``
