set nu "line numbers
set ignorecase "ignore case when searching
set smartcase "do not ignore case if search is not all lowercase
set expandtab "tabs => spaces
set shiftwidth=2 "indentation
set softtabstop=2 "tab is 2 spaces
set scrolloff=3 "show 3 lines of context around cursor
set laststatus=2 "always display statusline
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

"lint
let g:ale_linters = {
      \'javascript': ['eslint']
      \}
let g:ale_lint_on_text_changed = 'never'
let g:ale_fixers = {
\   'javascript': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
\}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-w> :ALEFix<CR>

"lightline theme
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
