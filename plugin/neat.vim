" ============================================================================
" File:        neat.vim
" Description: A pretty printing plugin for VIM.
" Author:      Sebastian Sareyko <sebastian@sareyko.net>
" License:     New (3-clause) BSD License. See COPYING for details.
" Website:     https://bitbucket.org/sareyko/neat.vim
" Version:     1.0
" ============================================================================

if exists('g:loaded_neat')
    finish
endif
let g:loaded_neat = 1

function! s:Neat(...) range
    if a:0 == 0
        let ft = &filetype
    else
        let ft = a:1
    endif
    let neat_command = 'g:neat#' . ft . '#commands'
    try
        let neat_commands = eval(neat_command)
    catch /^Vim\%((\a\+)\)\=:E121/
        echoerr 'Neat command not defined for filetype "'
                    \ . ft
                    \ . '": "'
                    \ . neat_command
                    \ . '"'
        return
    endtry
    for cmd in neat_commands
        execute a:firstline . ','. a:lastline . cmd
    endfor
endfunction

command! -nargs=? -range=% -complete=filetype
            \ Neat
            \ <line1>,<line2>call s:Neat(<f-args>)
