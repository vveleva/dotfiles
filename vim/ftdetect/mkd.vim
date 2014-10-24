" markdown filetype file
if exists("did\_load\_filetypes")
    finish
endif

augroup mkd
    autocmd! BufRead,BufNewFile *.mkd   setfiletype mkd
    autocmd BufRead *.mkd setlocal autoindent
    autocmd BufRead *.mkd setlocal formatoptions=tcroqn2
    autocmd BufRead *.mkd setlocal comments=n:>
    autocmd BufRead *.mkd setlocal tabstop=1
    autocmd BufRead *.mkd setlocal shiftwidth=1
    autocmd BufRead *.mkd setlocal softtabstop=1
    autocmd BufRead *.mkd setlocal ignorecase
augroup END
vmap K :s/^/> /<CR>
