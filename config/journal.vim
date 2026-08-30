let g:journal_dir = $HOME . '/Documents/gdrive/journal'


function! Journal(...) abort
    if a:0
        let date = a:1
    else
        let date = strftime('%Y-%m-%d')
    endif

    let year  = strpart(date, 0, 4)
    let month = strpart(date, 5, 2)

    let dir  = g:journal_dir . '/' . year . '/' . month
    let file = dir . '/' . date . '.md'

    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif

    if !filereadable(file)
        let weekday = strftime('%A', strptime('%Y-%m-%d', date))

        call writefile([
                    \ '# ' . weekday . ', ' . date,
                    \ '',
                    \ '## Tasks',
                    \ '',
                    \ '- [ ] ',
                    \ '',
                    \ '## Research',
                    \ '',
                    \ '### Progress',
                    \ '',
                    \ '### Questions',
                    \ '',
                    \ '### Ideas',
                    \ '',
                    \ '## Notes',
                    \ '',
                    \ '## Thoughts',
                    \ '',
                    \ ''
                    \ ], file)
    endif

    execute 'edit ' . fnameescape(file)
endfunction

command! -nargs=? Journal call Journal(<f-args>)

command! Today Journal


function! JournalRelative(days) abort
    let today = localtime()
    let then  = today + (a:days * 86400)
    let date  = strftime('%Y-%m-%d', then)
    call Journal(date)
endfunction

command! Yesterday call JournalRelative(-1)
command! Tomorrow  call JournalRelative(1)

command! JournalNew Journal


function! JournalTodo() abort
    let file = g:journal_dir . '/todo.md'

    if !filereadable(file)
        call writefile([
                    \ '# TODO',
                    \ '',
                    \ '## Important',
                    \ '',
                    \ '## Research',
                    \ '',
                    \ '## Personal',
                    \ '',
                    \ ''
                    \ ], file)
    endif

    execute 'edit ' . fnameescape(file)
endfunction

command! JournalTodo call JournalTodo()


function! JournalQuicknote() abort
    let file = g:journal_dir . '/quicknote.md'

    if !filereadable(file)
        call writefile([
                    \ '# Quick Notes',
                    \ '',
                    \ ''
                    \ ], file)
    endif

    execute 'edit ' . fnameescape(file)
endfunction

command! JournalQuicknote call JournalQuicknote()


function! JournalToggleTodo() abort
    let line = getline('.')

    if line =~# '^\s*-\s*\[ \]'
        substitute/\[ \]/[x]/
    elseif line =~# '^\s*-\s*\[[xX]\]'
        substitute/\[[xX]\]/[ ]/
    else
        echo 'Not a TODO line'
    endif
endfunction

command! JournalToggle call JournalToggleTodo()


function! JournalAddTodo() abort
    call append(line('.'), '- [ ] ')
    normal! j$
    startinsert
endfunction

command! JournalAddTodo call JournalAddTodo()


function! JournalTimestamp() abort
    execute "normal! o" . strftime('### %H:%M') . "\<CR>"
endfunction

command! JournalTimestamp call JournalTimestamp()


function! JournalGrep(...) abort
    if a:0 == 0
        echoerr 'Usage: JournalGrep pattern'
        return
    endif

    let pattern = join(a:000, ' ')

    let files = glob(g:journal_dir . '/**/*.md', 1, 1)

    if empty(files)
        echoerr 'No journal files found'
        return
    endif

    execute 'vimgrep /' . escape(pattern, '/') . '/j ' .
                \ join(map(files, 'fnameescape(v:val)'), ' ')

    copen
endfunction

command! -nargs=+ JournalGrep call JournalGrep(<f-args>)


function! JournalTodos() abort
    let files = glob(g:journal_dir . '/**/*.md', 1, 1)

    if empty(files)
        echo 'No journal files found'
        return
    endif

    execute 'vimgrep /^\s*-\s*\[ \]/j ' .
                \ join(map(files, 'fnameescape(v:val)'), ' ')

    copen
endfunction

command! JournalTodos call JournalTodos()


function! JournalDone() abort
    let files = glob(g:journal_dir . '/**/*.md', 1, 1)

    if empty(files)
        echo 'No journal files found'
        return
    endif

    execute 'vimgrep /^\s*-\s*\[[xX]\]/j ' .
                \ join(map(files, 'fnameescape(v:val)'), ' ')

    copen
endfunction

command! JournalDone call JournalDone()


function! JournalRandom() abort
    let files = glob(
                \ g:journal_dir . '/????/??/????-??-??.md',
                \ 1,
                \ 1
                \ )

    if empty(files)
        echo 'No journal entries found'
        return
    endif

    let file = files[rand() % len(files)]
    execute 'edit ' . fnameescape(file)
endfunction

command! JournalRandom call JournalRandom()


nnoremap <leader>j :Today<CR>
nnoremap <leader>t :JournalTodo<CR>
nnoremap <leader>q :JournalQuicknote<CR>

nnoremap <leader>x :JournalToggle<CR>
nnoremap <leader>a :JournalAddTodo<CR>
nnoremap <leader>T :JournalTimestamp<CR>

nnoremap <leader>y :Yesterday<CR>
nnoremap <leader>o :Tomorrow<CR>

nnoremap <leader>f :JournalGrep 
nnoremap <leader>u :JournalTodos<CR>
nnoremap <leader>d :JournalDone<CR>
