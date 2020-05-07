" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" (@author Drake Provost) Uncomment the following to have Vim show a different
" color scheme than the default
colorscheme torte

" (@author Drake Provost) Uncomment the following to have Vim autocomplete 
" open braces for you while in insert mode
inoremap {<CR> {<CR>}<Esc>ko

" (@author Drake Provost) Uncomment the following to have Vim use kj instead
" of <Esc> while in various modes:
" Esc in insert mode:
inoremap kj <Esc>
" Esc in visual mode:
vnoremap kj <Esc>
" Esc in command mode (Note: In command mode mappings to esc run the command
" for some some odd historical vi compatibility reason. We use the alternate
" method of exiting which is Ctrl-C):
cnoremap kj <C-C>

" (@author Drake Provost) Uncomment the following to make it easier to end
" control structures in shell scripts
" if statements:
inoremap fi<CR> <BS>fi<Esc>O
" case statements:
inoremap c<CR> c<Esc>O
" for, while, until, and select loops:
inoremap one<CR> one<Esc>O

