set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
 Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
" Below are my own plugins
" Auto Pairs
Plugin 'jiangmiao/auto-pairs'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
let g:AutoPairFlyMode=1
" Super Tab
Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&completefunc', '&omnifunc']
let g:SuperTabContextDefaultCompletionType = "<c-p>"
let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced = 1
let s:ContextDiscover=1
" Tag List
Plugin 'vim-scripts/taglist.vim'
" OpenCL Syntax
Plugin 'petRUShka/vim-opencl'
Plugin 'scrooloose/syntastic'
" Gith differ
Plugin 'airblade/vim-gitgutter'
" OmniCppComplete
Plugin 'vim-scripts/OmniCppComplete'
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
let OmniCpp_SelectFirstItem = 1
let OmniCpp_LocalSearchDecl = 1
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Below are my settings
syntax on
set t_Co=256
colorscheme slate
set smarttab
set autoindent
set ts=4 sw=4 noet
set hlsearch
set nu
set path+=/opt/X11/include/
" Uncomment the following to have Vim jump to the last position when
" " reopening a file
if has("autocmd")
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" git commit
autocmd Filetype gitcommit setlocal spell textwidth=72
" Finish my seeting
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
