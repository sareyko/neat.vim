function neat#html#neat() range
    if executable('tidy')
        execute a:firstline . ',' . a:lastline . '!tidy -i 2> /dev/null'
        execute a:firstline . ',' . a:lastline . 'normal =='
    else
        echoerr 'tidy not found'
    endif
endfunction
let neat#html#commands = [ 'call neat#html#neat()' ]
