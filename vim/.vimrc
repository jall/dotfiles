" Add a coloured column at 80 characters
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Monokai theme
syntax enable
colorscheme molokai
let g:rehash256 = 1

" Line numbers
set nu
