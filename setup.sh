#!/bin/bash

set -x -e

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

# link up git dotfiles to home dotfiles
ln -sf $dir/gitconfig ~/.gitconfig
ln -vsf $dir/profile ~/.profile
ln -vsf $dir/inputrc ~/.inputrc
ln -vsf $dir/bashrc ~/.bashrc
ln -vsf $dir/vimcatrc ~/.vimcatrc
mkdir -p ~/.config/git
ln -vsf $dir/gitignore ~/.config/git/ignore
ln -vsf $dir/pythonrc ~/.pythonrc
for x in $dir/bashrc.*; do
    ln -vsf $x ~/.$(basename $x)
done


# install brew of some kind
# OSX: ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# linux:
if [[ $PLATFORM == *"linux"* ]]; then
   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
   PATH="$HOME/.linuxbrew/bin:$PATH"
elif [[ $PLATFORM == *"darwin"* ]]; then
   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
   echo Could not figure out what platform this is: $PLATFORM
   echo Exiting before bad things happen
   exit 1
fi

# install nvim
brew install neovim/neovim/neovim

# verify this works when there's already shit here...
if [ -d ~/.config/nvim ]; then
    mv ~/.config/nvim ~/.config/nvim.$(date +%s)
fi
mkdir -p ~/.config/

ln -s $dir/vim ~/.config/nvim

# command line utilities
brew install python
brew install git
brew install fasd
brew install ag
brew install jq
brew install aria2
brew install bash-git-prompt
brew install numpy
brew install scipy
brew install matplotlib

pip install jinja2 yaml editdistance pycrypt ipython sympy rlcompleter
#brew tap universal-ctags/universal-ctags
#brew install universal-ctags/universal-ctags/universal-ctags

#brew install homebrew/dupes/openssh
