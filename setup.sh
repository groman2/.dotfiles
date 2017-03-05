#!/bin/bash

# set -x -e

# Running with -x makes it hard to tell what's going on
set -e

if [[ -z $HOSTTYPE ]]; then
   HOSTTYPE=unknown
fi

if [[ $OSTYPE == *"linux"* ]]; then
    PLATFORM=linux.$HOSTTYPE
elif [[ $OSTYPE == *"darwin"* ]]; then
    PLATFORM=darwin.$HOSTTYPE
fi



# get directory this script is in
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git -C $dir submodule update --init --recursive

# link up git dotfiles to home dotfiles
ln -sf $dir/gitconfig ~/.gitconfig
ln -vsf $dir/profile ~/.profile
ln -vsf $dir/inputrc ~/.inputrc
ln -vsf $dir/bashrc ~/.bashrc
ln -vsf $dir/vimrc ~/.vimrc
ln -vsf $dir/tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux
ln -vsfT $dir/tmux-plugins ~/.tmux/plugins
mkdir -p ~/.config/git
ln -vsf $dir/gitignore ~/.config/git/ignore
ln -vsf $dir/pythonrc ~/.pythonrc
for x in $dir/bashrc.*; do
    ln -vsf $x ~/.$(basename $x)
done

yesbrew=1
yespip=1
yespylab=1

while [[ ! -z $1 ]]; do
   case "$1" in
       nobrew)
           unset yesbrew
           nobrew=1
       ;;

       nopip)
           unset yespip
           nopip=1
       ;;

       nopylab)
           unset yespylab
           nopylab=1
       ;;

       vm)
          echo VM Mode - no brew or pylab
          unset yesbrew
          unset yespylab
          nobrew=1
          nopylab=1
       ;;
    esac
    shift
done

if [[ -z $yesbrew ]]; then
    echo Running in no-brew mode, try installing packages systemwide manually
    echo Xenial:
    echo   sudo add-apt-repository ppa:neovim-ppa/stable
    echo   sudo apt-get update
    echo   sudo apt-get install neovim jq aria2
    echo
    echo
fi
# install brew of some kind
# OSX: ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# linux:
if [[ -z $nobrew ]]; then
    if [[ $PLATFORM == *"linux"* ]]; then
       if [ ! -e $HOME/.linuxbrew/bin/brew ]; then
          ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
       fi
       PATH="$HOME/.linuxbrew/bin:$PATH"
    elif [[ $PLATFORM == *"darwin"* ]]; then
       if [ ! -e /usr/local/bin/brew ]; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    else
       echo Could not figure out what platform this is: $PLATFORM
       echo Exiting before bad things happen
       exit 1
    fi
fi

if ! which brew || [[ -z $yesbrew ]]; then
    function brew() {  echo skipping brew $*; }
    nobrew=1
    unset yesbrew
fi

if ! which pip || [[ -z $yespip ]]; then
    function pip() { echo skipping pip $*; }
    nopip=1
    unset yespip
fi

# Nope, bad idea
#if ! $(which g++) && ! (which clang++); then
#  brew install gcc
#fi
if [[ -z $nobrew ]] && {  ! which make || ! which c++; }; then
  echo Cannot install neovim and other brew packages because basic make/c++ packages are not installed
  exit 1
fi

# command line utilities
brew install python
brew install git
brew install fasd
brew install ag
brew install jq
brew install aria2
brew install bash-git-prompt
brew install tmux
brew install mobile-shell
# FZF is installed through nvim plugin manager: brew install fzf
if [[ $PLATFORM == *"darwin"* ]]; then
  brew install reattach-to-user-namespace
fi
#brew install homebrew/python/numpy
#brew install homebrew/python/scipy
#brew install homebrew/python/matplotlib


# install nvim
brew install neovim/neovim/neovim

# verify this works when there's already shit here...
if [ -d ~/.config/nvim ]; then
    mv ~/.config/nvim ~/.config/nvim.$(date +%s)
fi
mkdir -p ~/.config/

ln -s $dir/vim ~/.config/nvim


pip install --user jinja2 pyyaml editdistance pycrypto rlcompleter3 

if [[ -z $nopylab ]]; then
    pip install --user ipython sympy numpy scipy matplotlib
fi

#brew tap universal-ctags/universal-ctags
#brew install universal-ctags/universal-ctags/universal-ctags

#brew install homebrew/dupes/openssh
