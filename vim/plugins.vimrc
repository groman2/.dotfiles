" plugins
call plug#begin('~/.vim/plugged')

" Defaults {{{
  Plug 'tpope/vim-sensible'
" }}}

" Navigation {{{
  " Displays tags in a window, ordered by scope
  Plug 'majutsushi/tagbar'

  " A tree explorer plugin for vim
  Plug 'scrooloose/nerdtree'
  "
  " project configuration via 'projections'
  Plug 'tpope/vim-projectionist'

  " A command-line fuzzy finder written in Go
  let g:fzf_command_prefix = 'FZF'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " Active fork of kien/ctrlp.vim. Fuzzy file, buffer, mru, tag, etc finder.
  Plug 'ctrlpvim/ctrlp.vim'

  " Fast vim CtrlP matcher based on python
  Plug 'FelikZ/ctrlp-py-matcher'
" }}}

" UI Additions {{{
  " Colors {{{
    Plug 'dolio/vim-hybrid'
    Plug 'morhetz/gruvbox'
    Plug 'chriskempson/base16-vim'
    Plug 'flazz/vim-colorschemes'
  " }}}

  " rainbow parentheses improved, shorter code, no level limit, smooth and fast, powerful configuration.
  Plug 'luochen1990/rainbow'

  " lean & mean status/tabline for vim that's light as air
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Better whitespace highlighting for Vim
  Plug 'ntpeters/vim-better-whitespace'

  " Toggle the cursor shape in the terminal for Vim.
  Plug 'jszakmeister/vim-togglecursor'
" }}}

" Commands {{{

  " comment stuff out (via leader-/)
  Plug 'tpope/vim-commentary'

  " quoting/parenthesizing made simple; e.g. ysiw) to wrap word in parens
  Plug 'tpope/vim-surround'

  " a Git wrapper so awesome, it should be illegal; :Gblame, etc
  Plug 'tpope/vim-fugitive'

  " easily search for, substitute, and abbreviate multiple variants of a word
  Plug 'tpope/vim-abolish'

  " Vim sugar for the UNIX shell commands that need it the most; e.g. :Find, :Wall
  Plug 'tpope/vim-eunuch'

  " Run a command over every entry in the quickfix list (:Cdo) or location list (:Ldo).
  Plug 'Peeja/vim-cdo'

  " Vim script for text filtering and alignment; e.g. :Tabularize /,
  Plug 'godlygeek/tabular'

  " Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'
  Plug 'rking/ag.vim'

  " asynchronous build and test dispatcher
  Plug 'tpope/vim-dispatch'

  " Syntax checking hacks for vim
  Plug 'benekastah/neomake'

  " Functions to toggle the [Location List] and the [Quickfix List] windows.
  Plug 'milkypostman/vim-togglelist'

  " Add emacs/bash/cocoa key bindings to vim, in insert and command-line modes.
  Plug 'maxbrunsfeld/vim-emacs-bindings'

" }}}

" Automatic Helpers {{{
  " wisely add "end" in ruby, endfunction/endif/more in vim script, etc
  Plug 'tpope/vim-endwise'

  " enable repeating supported plugin maps with '.'
  Plug 'tpope/vim-repeat'

  " automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
  Plug 'tpope/vim-sleuth'

  " pairs of handy bracket mappings; e.g. [<Space> and ]<Space> add newlines before and after the cursor line
  Plug 'tpope/vim-unimpaired'

   " provides an asynchronous keyword completion system in the current buffer
   Plug 'Shougo/deoplete.nvim'

   " Speed up Vim by updating folds only when called-for.
   let g:fastfold_savehook = 0
   let g:fastfold_fold_command_suffixes = []
   let g:fastfold_fold_movement_commands = []
   Plug 'Konfekt/FastFold'

   " Provide easy code formatting in Vim by integrating existing code formatters.
   Plug 'Chiel92/vim-autoformat'
" }}}

" Language specific {{{

  " Go {{{
    Plug 'fatih/vim-go'
    Plug 'godoctor/godoctor.vim'
  " }}}

  " A solid language pack for Vim.
  " Adds 70+ languages and optimizes loading and installing.
  Plug 'sheerun/vim-polyglot'
" }}}

call plug#end()