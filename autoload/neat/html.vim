function neat#html#neat()
    if executable('tidy')
        execute '%!tidy --tidy-mark false '
                    \ . '--doctype omit '
                    \ . '-indent --indent-spaces ' . shiftwidth()
                    \ . ' 2> /dev/null'
    else
        echoerr 'tidy not found'
    endif
endfunction
let neat#html#commands = [ 'call neat#html#neat()' ]
