"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / /	/__| |/ / / / / / / /
"/___/_/ /_/_/|__(_)___/_/_/ /_/ /_/


" Always source these files
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/functions.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/vim-plug/plugins.vim

" Ordinary neovim
source $HOME/.config/nvim/themes/gruvbox.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/goyo.vim
source $HOME/.config/nvim/plug-config/rainbow.vim
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/themes/airline.vim




nnoremap <C-s> :source $HOME/.config/nvim/init.vim<CR>
