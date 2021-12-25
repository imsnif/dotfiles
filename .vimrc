set nu relativenumber "line numbers
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

" set termguicolors

" the configuration options should be placed before `colorscheme miramare`
let g:miramare_enable_italic = 1
let g:miramare_disable_italic_comment = 1
colorscheme miramare

" colorscheme 256-jungle
" colorscheme jellybeans

" Load this plugin at this timing
" to define :Arpeggio, arpeggio#map() and others used later.
packadd vim-arpeggio

"highlight cursor line
set cursorline
hi CursorLine term=none cterm=none ctermbg=235
hi CursorLineNr term=bold cterm=none ctermfg=Yellow gui=bold guifg=Yellow guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi LineNr ctermbg=NONE

"share clipboard between instances
set clipboard^=unnamedplus

"properly expand multi-line blocks
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

"fast navigation regardless of codeblocks
" map J 10j
" map K 10k

"ignore typing errors
:command WQ wq
:command Wq wq
:command W w
:command Q q

" disable swap files
" set noswapfile

" strip whitespaces
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" lint
 let g:ale_completion_enabled = 1
 let g:ale_rust_cargo_check_tests = 1
 let g:ale_lint_on_text_changed = 'never'
 let g:ale_linters = {
       \'javascript': ['standard'],
       \'rust': ['cargo'],
       \'typescript': ['tsserver']
       \}
 let g:ale_fixers = {
 \   'javascript': ['standard', 'trim_whitespace'],
 \   'rust': ['remove_trailing_lines', 'trim_whitespace', 'rustfmt'],
 \}

" the ^[ is an Esc char that comes before the 'a'
" In most default configs, ^[a may be typed by pressing first <C-v>, then <M-a>
 nmap <silent> K <Plug>(ale_previous_wrap)
 nmap <silent> J <Plug>(ale_next_wrap)
 nmap <silent> <C-b> :ALEFix<CR>

" temporarily disable ale
autocmd BufEnter *.js ALEDisable

" lightline theme
"" let g:lightline = {
""       \ 'colorscheme': 'jellybeans',
""       \ }
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }

" filetype plugin on
set omnifunc=syntaxcomplete#Complete

" color errors
" ":hi SpellBad term=none cterm=none ctermfg=5 ctermbg=9 guifg=#5f005f
" ":hi Error term=none cterm=none ctermfg=5 ctermbg=9 guibg=#5f005f

" temporary stuff
" set t_Co=256   " This is may or may not needed.

" set background=light
" colorscheme PaperColor
