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

" EVERYTHING BELOW THIS LINE ADDED BY DRAKE PROVOST
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Uncomment the following to have Vim show a different color scheme than 
" the default
colorscheme torte

" Uncomment the following to have Vim autocomplete open braces for you while
" in insert mode
inoremap {<CR> {<CR>}<Esc>ko

" Uncomment the following to have Vim use kj instead of <Esc> while in
" various modes:
" Esc in insert mode:
inoremap kj <Esc>
" Esc in visual mode:
vnoremap kj <Esc>
" Esc in command mode (Note: In command mode mappings to esc run the command
" for some some odd historical vi compatibility reason. We use the alternate
" method of exiting which is Ctrl-C):
cnoremap kj <C-C>

" Uncomment the following to make it easier to end control structures in shell 
" scripts
"function! CloseSh(start, end, before)
"    " Entering the actual start
"    exe"norm!i".a:start
"      
"   " Making sure that the 'before' is on the same line,
"    " or one line before cursor
"    if search('.*'.a:before.'.*\n\?.*\%#', 'n') == '0'
"        " If it's not the case, we behave as if nothing happened
"        exe"norm!a\<SPACE>"
"        call setpos('.', [0, line('.'), 1000, 0, 1000])
"        return
"    endif
"
"    " If match found, we can continue:
"    " adding the end tag bellow
"    exe"norm!o".a:end
    " new line above"
"    exe"norm!O\<SPACE>\<BS>"
"    " force cursor at the end of line
"    call setpos('.', [0, line('.'), 1000, 0, 1000])
"endfunction
" if statements:
inoremap fi<CR> <BS>fi<Esc>O
"autocmd FileType sh iab <buffer> then then<CR>fi<C-o>O<SPACE><BS><C-o>z
"autocmd FileType sh inoreab <buffer> then :call CloseSh('then', 'fi', '\<if\>')<CR><C-o>z
" case statements:
inoremap c<CR> c<Esc>O
"autocmd FileType sh iab <buffer> case case<CR>esac<C-o>O<SPACE><BS><C-o>z 
"autocmd FileType sh inoreab <buffer> in :call CloseSh('in', 'esac', '\<case\>')<CR><C-o>z
" for, while, until, and select loops:
inoremap one<CR> one<Esc>O
"autocmd FileType sh iab <buffer> do do<CR>done<C-o>O<SPACE><BS><C-o>z
"autocmd FileType sh inoreab <buffer> do :call CloseSh('do', 'done', '\<for\>')<CR><C-o>z
"autocmd FileType sh inoreab <buffer> do :call CloseSh('do', 'done', '\<while\>')<CR><C-o>z
"autocmd FileType sh inoreab <buffer> do :call CloseSh('do', 'done', '\<until\>')<CR><C-o>z
"autocmd FileType sh inoreab <buffer> do :call CloseSh('do', 'done', '\<select\>')<CR><C-o>z

" Uncomment the following for better kv formatting and syntax highlighting
if hostname() != "turing" && hostname() != "hopper"
    " Uncomment the following to load vim-plug automatically
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    " List plug-ins below to be loaded.
    call plug#begin()
    Plug 'farfanoide/vim-kivy'	" for kv formatting and syntax highlighting
    call plug#end()
    " undo the setting of vim-kivy plugin that displays $ at
    " end of line
    set listchars=""
    set nolist
endif

" Uncomment the following to change the default split direction
set splitbelow		" Split below instead of above
set splitright		" Split right instead of left

" Uncomment the following to disable to Windows system bell in vim
set visualbell

" Uncomment the following to allow normal mode tab completion for filenames
" like how bash works (e.g. while using :s)
set wildmode=longest,list
set wildmenu

" Uncomment the following to prevent vim from using the X clipboard (if vim
" has sluggish startup from failure to find X server)
if hostname() == "DESKTOP-21RFLUN"
    set clipboard=exclude:.*
endif
