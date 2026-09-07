let s:fzf_loaded = 0
function! s:load_fzf() abort
  if s:fzf_loaded | return | endif
  let s:fzf_loaded = 1

  for cmd in ['Files', 'Rg', 'Buffers', 'GFiles']
    if exists(':' . cmd)
      execute 'delcommand ' . cmd
    endif
  endfor

  packadd fzf
  packadd fzf.vim
endfunction

function! s:fzf_cmd(cmd, bang, args) abort
  call s:load_fzf()
  execute a:cmd . (a:bang ? '!' : '') . ' ' . a:args
endfunction

command! -bang -nargs=* -complete=dir Files   call s:fzf_cmd('Files', <bang>0, <q-args>)
command! -bang -nargs=* Rg                    call s:fzf_cmd('Rg', <bang>0, <q-args>)
command! -bang -nargs=* Buffers               call s:fzf_cmd('Buffers', <bang>0, <q-args>)
command! -bang -nargs=* GFiles                call s:fzf_cmd('GFiles', <bang>0, <q-args>)

nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>gg :GFiles<CR>
