if executable('nixd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'nixd',
        \ 'cmd': {server_info->['nixd']},
        \ 'allowlist': ['nix'],
        \ })
endif

if executable('nil')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'nil-ls',
        \ 'cmd': {server_info->['nil']},
        \ 'allowlist': ['nix'],
        \ })
endif

if executable('tinymist')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'tinymist',
        \ 'cmd': {server_info->['tinymist']},
        \ 'allowlist': ['typst'],
        \ })
endif

if executable('texlab')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'texlab',
        \ 'cmd': {server_info->['texlab']},
        \ 'allowlist': ['tex'],
        \ })
endif

if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'allowlist': ['rust'],
        \ })
endif

if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'allowlist': ['go'],
        \ })
endif

if executable('jdtls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'jdtls',
        \ 'cmd': {server_info->['jdtls']},
        \ 'allowlist': ['java'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

function! TinymistCmd(cmd) abort
    call lsp#send_request('tinymist', {
        \ 'method': 'workspace/executeCommand',
        \ 'params': {
        \   'command': a:cmd,
        \   'arguments': []
        \ },
        \ 'on_notification': {data -> execute('echom string(data)')}
        \ })
endfunction

command! TypstPreviewStart call TinymistCmd('tinymist.startDefaultPreview')
command! TypstPreviewStop  call TinymistCmd('tinymist.doKillPreview', 'default_preview')
command! TypstPinMain      call TinymistCmd('tinymist.pinMainToCurrent')
command! TypstUnpinMain    call TinymistCmd('tinymist.unpinMain')

augroup TypstLSPMappings
    autocmd!
    autocmd FileType typst nnoremap <buffer> <leader>tp :TypstPreviewStart<CR>
    autocmd FileType typst nnoremap <buffer> <leader>ts :TypstPreviewStop<CR>
    autocmd FileType typst nnoremap <buffer> <leader>pm :TypstPinMain<CR>
    autocmd FileType typst nnoremap <buffer> <leader>pu :TypstUnpinMain<CR>
augroup END

let g:lsp_semantic_enabled = 1

set updatetime=100
set completeopt=menu,menuone,noinsert,noselect
