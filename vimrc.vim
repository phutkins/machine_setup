" _vimrc file
" continually being redone by phutkins

" first thing's first
set nocompatible " forget about strict vi-compatability. It's right out.

" <leader> from http://learnvimscriptthehardway.stevelosh.com/chapters/06.html
let mapleader = ","

" VIM Plugins using https://github.com/junegunn/vim-plug
" automatic installation of vim-plug in this script is no longer supported for Windows 
if empty(glob('~/.vim/autoload/plug.vim'))
  " For 'macos' & 'linux'
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'        " powerline clone
Plug 'junegunn/vim-easy-align'      " Easy alignment
Plug 'tpope/vim-fugitive'           " git wrapper
Plug 'tpope/vim-unimpaired'         " mappings using [ and ] for settings
Plug 'mbbill/undotree'              " undo graph
" {{{
  nmap <leader>u  :UndotreeToggle<CR>
" }}}
Plug 'ConradIrwin/vim-bracketed-paste'  " turn on :set paste
Plug 'RRethy/vim-illuminate'        " highlight other uses of current word
Plug 'kshenoy/vim-signature'        " show marks in left-hand gutter
"Plug 'othree/xml.vim'               " editing xml
" {{{
  let g:xml_syntax_folding=1
" }}}

"if has('gui_running')
  Plug 'drmikehenry/vim-fontsize'     " <leader><leader>+ , <l><l>- to size. <l><l>= to enter repeatable 'font size' mode
"endif
" and some non-vim plugins
Plug 'magicmonty/bash-git-prompt'
Plug 'junegunn/fzf', { 'dir': '$HOME/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
  nnoremap <silent> <leader>w :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>h :History<CR>
  " These require Ag/Silver Searcher.  I don't use this 
  "nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
  "nnoremap <silent> <leader>. :AgIn 
  "nnoremap <silent> K :call SearchWordWithAg()<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction
" }}}
call plug#end()
" plugins can now be installed with :PlugInstall or :PlugUpdate

" standard in v5.7, this allows the use of ,e or ,s to navigate filesystem
nmap <leader>e  :Explore<CR>
nmap <leader>s  :Sexplore<CR>
nmap <leader>v  :Vexplore!<CR>
nmap <leader>c  :cclose<CR>
let g:netrw_liststyle= 1  " default to long listing form
" put filename in copy buffer in various forms. From http://vim.wikia.com/wiki/Copy_filename_to_clipboard
nmap <leader>yf :let @*=expand("%")<CR>
nmap <leader>yl :let @*=line(".")<CR>
nmap <leader>yp :let @*=expand("%:p")<CR>
" turn off last search's highlighting
nmap <leader>n  :noh<CR>
" I sometimes have the shift key on when I try to write a file. This is a lame fix for that.
" But-- it prevents me from using a capital W in command mode!
"cmap W w

" Use persistent history. From https://advancedweb.hu/2017/09/19/vim-persistent-undo/
if has("persistent_undo") && ThisOsType() != "windows"
    if !isdirectory("/tmp/.vim-undo-dir")
        call mkdir("/tmp/.vim-undo-dir", "", 0700)
    endif
    set undodir=/tmp/.vim-undo-dir
    set undofile
endif

" Better diffing tool. From https://github.com/chrisbra/vim-diff-enhanced/blob/master/README.md#update
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif
nmap ]d :cclose \| windo diffthis<CR>
nmap [d :diffoff!<CR>

command! CD cd %:p:h  " make CD command to cd to file's directory

"if !exists ("autocommands_loaded")
"  let autocommands_loaded = 1
"  autocmd FileChangedShell    *   echohl ErrorMsg | echo "A file has changed outside of Vim." | echohl None
"endif

" prevents F1 == ":help" for insert&command-line, normal&visual&operator modes
" very good for my laptop, where those keys are very close to each other.
"noremap! <F1> 
"noremap  <F1> 

" maps ALT-] to a grep in pwd for the word under the cursor; prints out list
"map <M-]> :vimgrep  *<CR> \| :copen<CR>
"map <M-]> :vimgrep <cword> * **/*src/* **/*inc/* <CR> \| :copen<CR>
"map <M-]> :vimgrep <cword> `find -type f -exec grep -Iq '' '{}' ';' -print` <CR> \| :copen<CR>
" Experiment to use :Ggrep instead... how to use this if only in a git repo? 
map <M-]> :Ggrep <cword><CR>

" :w!! from https://dev.to/jovica/the-vim-trick-which-will-save-your-time-and-nerves-45pg

" repeat last operation on visual block.
vmap . :normal .<CR>
" better indentation movement in visual mode
vnoremap < <gv
vnoremap > >gv

" set all those behavior variables
"set winaltkeys=no " allows me to re-map ALT keys willy-nilly
behave xterm  " the mouse behaves like it does in xterm. other option: mswin
"set mousemodel=extend   " rt. mouse button extends selection, like xterm
set history=50  " remember 50 last things I did
set ruler       " tells line,column in lower right-hand corner of frame/window
set shiftwidth=2  " shiftwidth is 2 spaces (used by << and >> commands)
set shiftround  " rounds indent to multiple of shiftwidth (above)
set tabstop=4   " display tabs as 4 spaces (standard)...
set softtabstop=4 " ... but pretend that the TAB key produces 4 spaces
set expandtab   " when you hit TAB key, inserts equal # of spaces
set smarttab    " tabs get aligned on softtabstop multiples... i think
set textwidth=79 " continue on next line in 78th column. helpful in .txt files.
set autoindent  "  remember the spacing for the next line
"set smartindent " indents for code blocks. great for programming languages
                " mostly superceded by 6.0 indent files
set ignorecase  " ignore case in searches ...
"set smartcase   " ... except when search contains UC. (but ignorecase for "*")
set nobackup    " won't create those annoying 'filename~' files
set incsearch   " when typing in searches, jumps around file to show matches
set hlsearch    " highlights text that I'm searching for
set noerrorbells " turns off stupid beeping for errors with messages.
set visualbell t_vb=""  " no beeping.
set showmatch   " blinks the cursor on matching [({})].
set fileformat=unix
set noequalalways   " when splitting windows, don't equally resize. use ^W= 
set report=1    " reports :substitute changes for >N changes.
set backspace=indent,eol,start " <BS> kills indents,eols,starts of insert
set whichwrap+=<,>,[,]         " arrow keys follow wrap to next line
set showbreak=> " character to put at start of wrapped lines.
set grepprg=grep\ -n    " uses 'grep' for :grep
"set titlelen=45 " cuts the title name so I can see name when I CTRL-TAB in Win
set titlestring=%t  " title is only the base filename
set wildmenu    " shows wildcard completions in menu bar
set switchbuf=useopen " when jumping to a file, go to already open version
set shellpipe=2>&1\|\ tee   " pipes both STDOUT and STDERR for :make

if ThisOsType() == "linux"
set clipboard=unnamedplus,autoselectplus  " uses register(+) for all cuts/pastes
else " For 'macos' & 'windows'
set clipboard=unnamed,autoselect    " uses OS register (*) for all cuts/pastes
endif

" folding
set foldmethod=syntax   " fold according to file syntax
set nofoldenable        " start with folds all open

" === TAGS === 
" remember to ctags (or etags, or use tags script) every once in a while!
"  get rid of annoying double-listing in Windows.  only lowercase.
set tags=./tags,tags
if ThisOsType() == 'windows'
  set tags+=c:\temp\tags
endif
"set tags=./tags,tags,c:\temp\tags
"  process europa-specific tags
"map <F10>  :! ctags *.pm *.pl<CR>
"map <F11>  :sp tags<CR>:%s/^\([^	:]*:\)\=\([^	]*\).*/syntax keyword Tag \2/<CR>:noh<CR>:wq! tags.vim<CR>/^<CR><F12>
"map <F12>  :so tags.vim<CR>

" === FONTS ===
" Different screen fonts.  Only use one.
" I think Terminal looks best on large screens.  It fits in a whole bunch of
" lines on the screen, and isn't scrawny like most other fonts.
" Andale is pretty good for small screens.  Unfortunately, Andale is not
" standard, and must be installed from Microsoft's fonts webpage
" (www.microsoft.com/truetype/free.htm).  I also think that  it looks a little
" washed out on a white background, so you might want to use this with a black
" background (see below).

" fonts that I think are pretty:
"set guifont=Terminal:h9:w6 
"set guifont=Andale_Mono:h7
"set guifont=Crystal:h8
if ThisOsType() == 'macos'
  set guifont=Lucida_Console:h12
elseif ThisOsType() == 'windows'
  set guifont=Lucida_Console:h12
else    " linux
  "set guifont=Monospace\ 9
  "set guifont=Liberation\ Mono\ 9
  set guifont=Ubuntu\ Mono\ 10
endif

" This was taken directly from the :help titlestring page.
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)


" normal behavior is black text on white background.  to invert this:
highlight Normal guibg=black guifg=white
set background=dark
" or, use a pre-made dark colorscheme
"colorscheme elflord
colorscheme torte
" a patch to elflord for color non-GUI terminals
highligh Visual cterm=reverse


" there are certain things that we want to do only if we're running 
" in gui-mode.
" Switch syntax highlighting on, when the terminal has colors
if has("gui_running")
    syntax on
    set lines=999 " basically, set vertical length to whole visible screen
    set guioptions=argmi 
        " (a)utoselect mouse-highlighted text into OS clipboard.
        " (r)ighthanded scrollbar. 
        " no menu. to get it back, change to (gm).
        " use Vim (i)con in X11
endif

" things I should put in here later:
" if the file being edited is a perl file, (or using the perl syntax), then
" redefine the 'define' and 'include' variables to be the perl equivalent.

" settings for bash shell command-line, for Cygwin systems. 
" Is there a way to test for this environment?
"set shell=bash
"set shellslash          " uses forward slashes for path names
"set shellcmdflag=-c      

" inoremap line prevents #comment lines from being smartindented to column 0
inoremap # X#

" if using ptf files, use indent for folding
au! BufNewFile,BufRead *.ptf        set foldmethod=syntax
au! BufNewFile,BufRead *.ptf        setf ptf

" if using vpp files, use verilog syntax highlighting 
au! BufNewFile,BufRead *.vpp        set filetype=verilog

" if using rt.rc files, use syntax highlighting like is used for verilog
au! BufNewFile,BufRead rt.rc*       set filetype=verilog

" somehow, this allows me to read .gz files
autocmd BufReadPre,FileReadPre      *.gz set bin
autocmd BufReadPost,FileReadPost    *.gz set nobin

" vim-fugitive for git integration
if (exists('g:loaded_fugitive'))
  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
endif

" from OSCON 2013: "More Instantly Better Vim" 
" https://github.com/quintonparker/more-instantly-better-vim/blob/master/plugin/hudigraphs.vim
" Make hidden tabs, trailing whitespace, and non-breaking spaces visible 
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list    " to turn off, 'set nolist'

" make 'cpoptions' empty.  
" [ph] I have no idea why we need to do this, but it's restored at the end.
if 1    " only do this when compiled with expression evaluation
  let mswin_save_cpo = &cpoptions
endif
set cpoptions=

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q> <C-V>

" For CTRL-V to work autoselect must be off
"set guioptions-=a

" CTRL-Tab is Next window
map <C-Tab> <C-W>w
imap <C-Tab> <C-O><C-W>w
cmap <C-Tab> <C-C><C-Tab>
" CTRL-Shift-Tab is Previous window
map <C-S-Tab> <C-W>W
imap <C-S-Tab> <C-O><C-W>W

" restore 'cpoptions'
set cpoptions&
if 1
  let &cpoptions = mswin_save_cpo
  unlet mswin_save_cpo
endif

" turn on any file-type based plugins that may be available
filetype plugin on


" ===  OBSOLETE FUNCTIONS === 
" errorformat for europa errors: 
"set errorformat=%\\s%#%f\ %l\ CALLED%m\,%mOCCURRED\ on\ %f\ %l\ \,%mOCCURRED\ on\ %\\\/%\\\/d%f\ %l\ \,%f:%l:\ %m
" errorformat, broken down:
"       europa callstack: 
"%\\s%#%f\ %l\ CALLED%m
"       europa errors/warnings (relative path):
"%mOCCURRED\ on\ %f\ %l\      
"       europa errors/warnings (full cygwin path in D: drive):
"%mOCCURRED\ on\ %\\\/%\\\/d%f\ %l\     
"       GCC:
"%f:%l:\ %m

" special mappings for perforce
"nmap <M-p>e :!p4 edit %:p<CR>     " edits current file in P4 default changelist
"nmap <M-p>a :!p4 add %:p<CR>      " adds current file to P4 default changelist
"nmap <M-p>d :call PerforceDiff()<CR> " calls function that does p4 diff

" spellchecker.  requires aspell. see http://aspell.sourceforge.net/
" ,c will check whole file. ,w will check word under cursor.
"nmap ,c :!c:/Program\ Files/aspell/aspell/aspell.exe check %<CR>
"nmap ,w :!echo <cword> \| c:/Program\ Files/aspell/aspell/aspell.exe pipe<CR>

" The following makes VIM act a lot like MSWindows.
" Rather than source $VIMRUNTIME/mswin.vim to make EVERYTHING 
" like mswindows, I'll only take the best parts of it.
" I only want C-c <copy>, C-x <delete>, and C-y <paste>, 
" and C-TAB <next window>.
"
" source $VIMRUNTIME/mswin.vim " sets up C-c <copy>, C-x <delete>, and C-y <paste>

