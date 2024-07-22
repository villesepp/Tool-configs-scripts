"basic level settings
set nocompatible    "some compatibility thing :)
set history=100     "history size
syntax on           "syntax highlighting
set number          "visible line numbers
set ruler           "visible ruler
set showmode        "display what mode it is
set tabstop=4       "tab stuff
set shiftwidth=4    "tab stuff
set ai              "automatic indentation
set modeline        "show file name
set ls=2            "this is part of file name
set belloff=all     "bell off

"make dirs under home so that they won't appear in src/ etc.
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "", 0700)
endif
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "", 0700)
endif

"set dirs and parameters for undo/swap/backup
set undodir=~/.vim/undo-dir//
set undofile
set undolevels=1000
set undoreload=50000
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//

"map W to w - reduces the chance not saving :)
cabb W w

"for https://github.com/junegunn/fzf
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'
call plug#end()
