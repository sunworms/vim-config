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

function! s:FormatBuffer() abort
  if !empty(&formatprg) && executable(split(&formatprg)[0])
    let view = winsaveview()
    silent! keepjumps normal! gggqG
    call winrestview(view)
  endif
endfunction
autocmd BufWritePre *.nix,*.typ call s:FormatBuffer()
