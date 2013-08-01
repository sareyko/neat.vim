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
    let neat_command = 'g:Neat' . substitute(ft, '.*', '\u&', '')
    if !exists(neat_command)
        echoerr 'Neat command not defined for filetype "'
                    \ . ft
                    \ . '": "'
                    \ . neat_command
                    \ . '"'
    else
        for cmd in eval(neat_command)
            execute a:firstline . ','. a:lastline . cmd
        endfor
    endif
endfunction

command! -nargs=? -range=% -complete=filetype
            \ Neat
            \ <line1>,<line2>call s:Neat(<f-args>)

let g:NeatJson = [ '!python -mjson.tool' ]
let g:NeatXml = [ 's/></>\r</ge', 'normal ==' ]
