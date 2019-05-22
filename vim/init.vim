" the root initializer

" Set python if it's not set

if !empty(glob('/usr/bin/python3')) && !exists('g:python3_host_prog')
  let g:python3_host_prog = '/usr/bin/python3'
endif
if !empty(glob('/usr/bin/python')) && !exists('g:python_host_prog')
  let g:python_host_prog = '/usr/bin/python'
endif

" get the plugin manager if we dont have it
" We have it, it's checked in
" if empty(glob('~/.config/nvim/autoload/plug.vim'))
"  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall | source $MYVIMRC
"endif

" load the rest of the config
source $HOME/.config/nvim/plugins.vimrc
source $HOME/.config/nvim/bindings.vimrc
source $HOME/.config/nvim/colors.vim
source $HOME/.config/nvim/general.vimrc
