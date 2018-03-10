set nu "line numbers
set ignorecase "ignore case when searching
set smartcase "do not ignore case if search is not all lowercase
set expandtab "tabs => spaces
set shiftwidth=2 "indentation
set softtabstop=2 "tab is 2 spaces
set scrolloff=3 "show 3 lines of context around cursor
syntax enable "syntax colors

filetype plugin indent on "indentation by filetype

"gief plugins
execute pathogen#infect()

colorscheme jellybeans

"highlight cursor line
set cursorline
hi CursorLine term=none cterm=none ctermbg=235

"share clipboard between instances
set clipboard^=unnamed

"properly expand multi-line blocks
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

"fast navigation regardless of codeblocks
map J 10j
map K 10k

"ignore typing errors
:command WQ wq
:command Wq wq
:command W w
:command Q q

"validate syntax
:command Ww w | SyntasticCheck
:command WW w | SyntasticCheck

"linting
let g:syntastic_javascript_checkers = ['standard']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': []  }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

"lightline theme
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
