set t_Co=256
set nu
set ignorecase
set smartcase
set expandtab
set shiftwidth=2
set softtabstop=2
set scrolloff=3 "show 3 lines of context around cursor
filetype plugin indent on
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 2
execute pathogen#infect()
syntax enable
colorscheme jellybeans
set t_Co=256
set cursorline
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorLine term=none cterm=none ctermbg=235
set autoread
set clipboard^=unnamed
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" jstandard validation
nnoremap <silent><F2>       : SyntasticCheck<CR>
inoremap <silent><F2> <C-O> : SyntasticCheck<CR>
vnoremap <silent><F2>       : SyntasticCheck<CR>

" show previous jshint error
nnoremap <silent><F3>       : lprevious<CR>
inoremap <silent><F3> <C-O> : lprevious<CR>
vnoremap <silent><F3>       : lprevious<CR>
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
au BufNewFile,BufRead *.ejs set filetype=html
set laststatus=2
set statusline+=%f

map J 10j
map K 10k

:command WQ wq
:command Wq wq
:command W w
:command Q q
:command Ww w | SyntasticCheck
:command WW w | SyntasticCheck

:command! -nargs=1 Co :normal oconsole.log('<args>', <args>)

let g:syntastic_javascript_checkers = ['standard']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': []  }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
