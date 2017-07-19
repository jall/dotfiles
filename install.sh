#!/usr/bin/env bash

# Get current directory
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load helper functions for rest of script
source "${DOTFILES_DIR}/system/.functions"

# Update dotfiles itself
if is-executable git -a -d "${DOTFILES_DIR}/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="${DOTFILES_DIR}/.git" pull origin master; fi

# Symlink dotfiles
ln -sv "${DOTFILES_DIR}/.bash_profile" "${HOME}"
ln -sv "${DOTFILES_DIR}/.inputrc" "${HOME}"
ln -sv "${DOTFILES_DIR}/git/.gitconfig" "${HOME}"
ln -sv "${DOTFILES_DIR}/git/.gitignore_global" "${HOME}"
ln -sv "${DOTFILES_DIR}/vim/.vimrc" "${HOME}"
# Ensure config folders exist before copying into them
mkdir -p "${HOME}/.vim/"
ln -sv "${DOTFILES_DIR}/vim/colors/" "${HOME}/.vim"

# Homebrew first for OSX dependencies
source install/brew.sh

# And now most big dependencies through brew
source install/brew-packages.sh

# OSX system settings
source osx/defaults.sh
