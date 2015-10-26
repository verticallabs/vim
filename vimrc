call pathogen#infect()
call pathogen#helptags()

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*.js.html,*/keatonrow/*/build/*.js,*.orig
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'max:20,results:20'
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']

"set paste
set hidden
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set nowrap
set showcmd
set incsearch
set guioptions-=T
set guioptions-=m
set diffopt=filler,iwhite
set scrollopt=jump
set ofu=syntaxcomplete#Complete
set completeopt=longest,menuone
set ignorecase
set smartcase
set path=.,/usr/include,**
set directory=/tmp
set nocompatible
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set noerrorbells visualbell t_vb=
set nofoldenable
set backupcopy=yes
set nobackup
set nowritebackup
set noswapfile
set noundofile

if exists('&undofile')
  set undofile
  set undodir=~/.vim/undo
  set undolevels=1000 "maximum number of changes that can be undone
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
end

syntax on
filetype plugin on
filetype plugin indent on
au BufNewFile,BufRead *.md set filetype=text
au BufNewFile,BufRead *.js set filetype=javascript
au BufNewFile,BufRead *.ejs set filetype=html
au! BufWritePost vimrc so %
au! BufWritePost .vimrc so %

function! OpenNewScratch()
  :set hlsearch
  :set incsearch
  :enew
  ":b /tmp/scratch
  :setlocal buftype=nowrite
  :setlocal noswapfile
endfunction

function! FindInFiles(query, paths)
  :call OpenNewScratch()
  :silent execute '%!file_search a:query a:paths'
endfunction

" COMMANDS **********************************************************************

":command! -nargs=1 Grep :!grep -ir <args> app lib
:command! -nargs=1 Grep :call FindInFiles("<args>", "app lib config")
:command! -nargs=1 GrepAll :call FindInFiles("<args>", '.')
:command! BuildTags :!ctags -R --exclude=.git/* --exclude=log/* --exclude=tmp/* . ~/.rvm
:command! -nargs=1 List :!find . -path './.git' -prune -o -path './tmp' -prune -o -type f -iname *.<args> -print

"navigation
"map <silent> <Leader>. :bn<Enter>
"map <silent> <Leader>, :bp<Enter>
"map <Leader>f :e **/*
"map <silent> <C-l> <Esc>:set hlsearch<Enter>:set incsearch<Enter>:enew<Enter>:setlocal buftype=nofile<Enter>:set nobuflisted<Enter>:%!file_list<Enter><Esc>
"imap <silent> <C-l> <Esc>:set hlsearch<Enter>:set incsearch<Enter>:enew<Enter>:setlocal buftype=nofile<Enter>:set nobuflisted<Enter>:%!file_list<Enter><Esc>
"map <C-k> :e **/*
"imap <C-k> <Esc>:e **/*
""map <C-t> <Esc>:enew<Enter>:setlocal buftype=nofile<Enter>:%:!file_search<Space>'.only('<Enter><C-j>
"map <C-b> <Esc>:enew<Enter>:setlocal buftype=nofile<Enter>:%:!file_search<Space>'debugger'<Enter><C-j>
"map <silent> <C-m> :ju<Enter>

map <C-S-c> :let @+ = expand("%")<Enter>
map <C-l> <Esc>:CtrlP<Enter>
map <C-f> "xy<C-g>'<C-r>x'<Enter>
map <silent> <C-j> :norm gF<Enter>z.
map <silent> <S-r> :%!beautify %<Enter>
map <silent> <C-h> :set nohlsearch!<Enter>
map <silent> <C-n> :set nonumber!<Enter>
"map <Tab> <C-w><C-w>
map <C-x> :enew<Enter>:setlocal buftype=nofile<Enter>:%!
map <C-g> <Esc>:enew<Enter>:setlocal buftype=nofile<Enter>:%:!file_search<Space>
"map <C-k> <Esc>:new<Enter>:VimShell<Enter>
map <C-E> <Esc>:AnsiEsc<Enter>
map <silent> <C-y> :!krgh %<Enter>
let @t = '^wi.only'

"search
"map <silent> <C-i> :set nohls<CR>:let @/ = ""<CR>:set hls<CR>
"map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"map <F9> :enew<Enter>:%!grep -ir '<<<' app spec config<Enter>
"map <F11> :enew<Enter>:%!grep -ir '>>>' app spec config<Enter>
"map <F12> :e $MYVIMRC<Enter>

" COLORS **********************************************************************

"hi Search ctermbg=DarkBlue ctermfg=White
hi String	ctermfg=DarkGray		
hi Constant	ctermfg=DarkGreen
hi LineNr ctermfg=DarkMagenta
au InsertLeave * hi Cursor guibg=red
au InsertEnter * hi Cursor guibg=green
"hi Comment ctermfg=DarkGreen
syn keyword Keyword self

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

