colorscheme solarized
set background=dark

" " custom colors
hi Normal guibg=#002833
hi Comment guifg=#306071
"
"
hi ColorColumn guibg=#003541
"
hi CursorColumn guibg=#002f3a
hi CursorLine guibg=#003541
hi CursorLineNr guibg=#003541 guifg=#ff8700
"
"
hi LineNr guifg=#5f5f87 guibg=#002833
hi VertSplit guifg=#5f5f87 guibg=#002833
hi Visual guifg=#003541 guibg=#3d92f8
hi StatusLine guifg=#121212 guibg=#72b824
hi StatusLineNC guifg=#5f5f87 guibg=#121212

let macvim_skip_colorscheme = 1

set fullscreen
" Disable scroll bars
set guioptions-=b
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guicursor+=a:blinkon0 " Disable cursor blink
