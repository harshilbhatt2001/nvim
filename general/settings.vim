syntax enable 				" Enables syntax highlighing
set hidden				" Required to keep multiple buffers open multiple buffers
set nowrap				" Display long lines in one line 
set encoding=utf-8			" The encoding displayed
set pumheight=10			" Makes popup menu smaller
set fileencoding=utf-8 			" The encoding written to file
set ruler				" Show cursor position at all times
set cmdheight=2				" More space to display messages
set mouse=a				" Enable mouse
set splitbelow				" Horizontal split will be below
set splitright				" Vertical split will be to the right
set tabstop=4				" Insert 4 spaces for tab
set shiftwidth=4			" Change number of space characters inserted for indentation
set smarttab				" Makes tabbing smarter, will realize you have 2 vs 4
set expandtab				" Convert tab to spaces
set smartindent				" Makes indenting smart
set autoindent				" Good autoindent
set laststatus				" Always display status line
set number				" Display line number
set cursorline				" Enable highlight of current line
set background=dark			" tell vim what background colour looks like
set showtabline=2			" Always show tab line
set noshowmode				" We don't need things like -- INSERT --
set nobackup				" Recommended by coc
set nowritebackup			" Recommended by coc
set shortmess+=c			" Don't pass messages to |ins-completion-menu|
set signcolumn=yes			" Always show the signcolumn, otherwise it would shift the text each time
set updatetime=500			" Faster completion
set timeoutlen=500			" Default is 1000ms
set clipboard=unnamedplus		" Copy paste between vim and everything else
set incsearch
" TODO:Include font here
" set foldcolumn=2			  " Folding abilities

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

au VimLeave * set guicursor=a:ver10-blinkon1	" fix cursor on leaving vim

