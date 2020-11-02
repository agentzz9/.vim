
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Mar 25
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" syntax on isn't really recommended, check and rectify in favour of enable in
" future...

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit


" NOW ADDING SOME THINGS OF MY OWN FROM HERE

" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>
" show line numbers  by default...its sad it doesnt :/ so here...
set number
"set relativenumber 
set foldenable

" little path hack to make vim behave like a fuzzy file searcher
" basically add child paths recursively to itself...
"set path+=**

set wildmenu
"set wildmode " not sure what this does but probably need it... TODO check this

set splitbelow splitright " why isnt this default...

" makes tag jumping possible 
"command! MakeTags !ctags -R .

" ^n is auto complete... ^n, ^p to move through the list,
" ^x^n for JUST this file
" ^x^f for filenames
" ^x^] for tags only
" lookup | ins_completion |
" .............................^y ..... to accept the completion
" suggestion(this keeps you inside insert, the good thing ;) )
"
"

" tweaks for browsing
"
"let g:netrw_banner = 0 " disable annoying banner
"let g:netrw_browse_split = 4 "open in prior window
"let g:netrw_altv = 1 "open splits to the right
"let g:netrw_liststyle=3 "tree view
"let g:netrw_list_hide = netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"now we can
":edit a folder to open a file browser
"<CR>/v/t to open in an h-split/v-split/tab
"check |netrw-browse-maps| for more mappings

"SNIPPETS!!!!
"
"read an empty html template and move cursor to line as defined by the
"commands
"
"after CR add normal mode commands to suite your need
"nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a 



"something related to build integration, rspec, ruby i dont know what...
"probably not useful for me right now... but would like to explore for maybe
"java/g++/python whatnot... sigh 

"hitchhikers guide to python3 dev in vim recommends these changes below
"set textwidth=79  " lines longer than 79 columns will be broken
"set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
"set tabstop=4     " a hard TAB displays as 4 columns
"set tabstop=8
"set expandtab     " insert spaces when hitting TABs
"set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
"set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line

" these next two lines are ideal if present in this order...
set ignorecase
set smartcase
" end ignorecase and smartcase...

" here goes nothing , pathogen likes its own bundle directory, however vim8
" now has pack directory as native package management support and this is how
" we using it.... initial install done for gruvbox
execute pathogen#infect('pack/{}')

" gruvbox says the following 
let g:gruvbox_italicize_comments=1
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_italic=1
set bg=dark
set t_Co=256 " adding this from wiki on vim to enable 256 colors, trying to get tmux work proporly
colorscheme gruvbox
"set termguicolors

