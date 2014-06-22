" ============================================================================
" File:        neat.vim
" Description: A pretty printing plugin for VIM.
" Author:      Sebastian Sareyko <sebastian@sareyko.net>
" License:     New (3-clause) BSD License. See COPYING for details.
" Website:     https://bitbucket.org/sareyko/neat.vim
" Version:     1.1
" ============================================================================

if exists('g:loaded_neat')
    finish
endif
let g:loaded_neat = 1

let s:scratch_name = '__neat_tmp__'

function! s:Scratch(buffer_name, filetype)
    execute 'new ' . a:buffer_name
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    execute 'setlocal ft=' . a:filetype
endfunction

function! s:HideScratch(buffer_name)
    execute 'bdelete ' . a:buffer_name
endfunction

function! s:GetSelection(line1, line2)
    let l:default_register = @"
    execute a:line1 . ','. a:line2 . 'y "'
    let l:selection = @"
    let @" = l:default_register
    return l:selection
endfunction

function! s:ReplaceBufferContents(buffer_name, contents)
    let l:default_register = @"
    let @" = a:contents
    normal ""p
    normal gg
    normal "_dd
    let @" = l:default_register
endfunction

function! s:GetBufferContents(buffer_name)
    let l:default_register = @"
    execute '%y "'
    let l:contents = @"
    let @" = l:default_register
    return l:contents
endfunction

function! s:ReplaceSelection(contents) range
    let l:default_register = @"
    execute a:firstline . ','. a:lastline . 'd _'
    let @" = a:contents
    normal ""P
    let @" = l:default_register
endfunction

function! s:Neat(...) range
    if a:0 == 0
        let l:ft = &filetype
    else
        let l:ft = a:1
    endif
    let l:neat_command = 'g:neat#' . l:ft . '#commands'
    try
        let l:neat_commands = eval(l:neat_command)
    catch /^Vim\%((\a\+)\)\=:E121/
        echoerr 'Neat command not defined for filetype "'
                    \ . l:ft
                    \ . '": "'
                    \ . l:neat_command
                    \ . '"'
        return
    endtry
    let l:selection = s:GetSelection(a:firstline, a:lastline)
    call s:Scratch(s:scratch_name, l:ft)
    call s:ReplaceBufferContents(s:scratch_name, l:selection)
    for cmd in l:neat_commands
        execute cmd
    endfor
    let l:contents = s:GetBufferContents(s:scratch_name)
    call s:HideScratch(s:scratch_name)
    execute a:firstline . ',' . a:lastline
                \ . 'call s:ReplaceSelection(l:contents)'
endfunction

command! -nargs=? -range=% -complete=filetype
            \ Neat
            \ silent <line1>,<line2>call s:Neat(<f-args>)
nnoremap <Leader>n :Neat<cr>
vnoremap <Leader>n :Neat<cr>
