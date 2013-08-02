function neat#xml#neat() range
    if executable('xmllint')
        execute a:firstline . ',' . a:lastline . '!xmllint --format -'
        execute a:firstline . ',' . a:lastline . 'normal =='
    else
        execute a:firstline . ',' . a:lastline . 's/></>\r</ge'
        execute a:firstline . ',' . a:lastline . 'normal =='
    endif
endfunction
let neat#xml#commands = [ 'call neat#xml#neat()' ]
