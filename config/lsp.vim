let s:lsp_loaded = 0
function! s:load_lsp() abort
  if s:lsp_loaded | return | endif
  let s:lsp_loaded = 1
  packadd vim-lsp
  packadd asyncomplete.vim
  packadd asyncomplete-lsp.vim
  call lsp#enable()
endfunction

augroup lazy_lsp
  au!
  au FileType nix,typst,tex,rust,go,java call s:load_lsp()
augroup END

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
    nmap <buffer> gy <plug>(lsp-type-definition)
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

function! TinymistPinMain() abort
    call lsp#send_request('tinymist', {
        \ 'method': 'workspace/executeCommand',
        \ 'params': {
        \   'command': 'tinymist.pinMain',
        \   'arguments': [expand('%:p')]
        \ },
        \ 'on_notification': {data -> execute('echom string(data)')}
        \ })
endfunction

function! TinymistUnpinMain() abort
    call lsp#send_request('tinymist', {
        \ 'method': 'workspace/executeCommand',
        \ 'params': {
        \   'command': 'tinymist.pinMain',
        \   'arguments': [v:null]
        \ },
        \ 'on_notification': {data -> execute('echom string(data)')}
        \ })
endfunction

let s:typst_preview_job = v:null

function! TypstPreviewStart() abort
    if s:typst_preview_job isnot v:null && job_status(s:typst_preview_job) ==# 'run'
        echom 'Typst preview already running'
        return
    endif
    let s:typst_preview_job = job_start(
        \ ['tinymist', 'preview', expand('%:p'),
        \  '--open', '--partial-rendering', '--invert-colors=auto'],
        \ {'out_io': 'null', 'err_io': 'null'})
endfunction

function! TypstPreviewStop() abort
    if s:typst_preview_job isnot v:null
        call job_stop(s:typst_preview_job)
        let s:typst_preview_job = v:null
    endif
endfunction

command! TypstPreviewStart call TypstPreviewStart()
command! TypstPreviewStop  call TypstPreviewStop()

augroup typst_preview_cleanup
    autocmd!
    autocmd VimLeavePre * call TypstPreviewStop()
augroup END

command! TypstPinMain   call TinymistPinMain()
command! TypstUnpinMain call TinymistUnpinMain()

let g:lsp_semantic_enabled = 1

set completeopt=menu,menuone,noinsert,noselect

augroup typst_cli_live_sync
    autocmd!
    autocmd TextChanged,TextChangedI *.typ silent! update
augroup END
