" Add a coloured column at 80 characters
if exists('+colorcolumn')
  set colorcolumn=72
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>72v.\+', -1)
endif

" Monokai theme
syntax enable
colorscheme molokai
let g:rehash256 = 1

" Line numbers
set nu

" Wrap text at 72 chars automatically in git commit messages
au FileType gitcommit set textwidth=72
