function neat#xml#neat()
    if executable('xmllint')
        execute '%!xmllint --format -'
        execute '%normal =='
    else
        execute '%s/></>\r</ge'
        execute '%normal =='
    endif
endfunction
let neat#xml#commands = [ 'call neat#xml#neat()' ]
