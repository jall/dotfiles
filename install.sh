#!/usr/bin/env bash

# Prompt to install Xcode through App Store if it doesn't already exist.
# There is no way I could find of installing Xcode through the CLI.
# This does not block the rest of the script.
if ! open -Ra "Xcode"; then
  xcode-select --install
fi

# Get current directory
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load helper functions for rest of script
source "${DOTFILES_DIR}/terminal/.functions"

# Update dotfiles itself
if is-executable git -a -d "${DOTFILES_DIR}/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="${DOTFILES_DIR}/.git" pull origin master; fi

# Ensure required directories exist before copying into them
mkdir -p "${HOME}/.vim/"
mkdir -p "${HOME}/.lein/"
mkdir -p "${HOME}/.gnupg/"
mkdir -p "${HOME}/bin/"
mkdir -p "${HOME}/Personal/"
mkdir -p "${HOME}/Personal/go"
mkdir -p "${HOME}/Work/"

# Symlink dotfiles
ln -sv "${DOTFILES_DIR}/system/.bash_profile" "${HOME}"
ln -sv "${DOTFILES_DIR}/system/.inputrc" "${HOME}"
ln -sv "${DOTFILES_DIR}/system/.editorconfig" "${HOME}"
ln -sv "${DOTFILES_DIR}/git/.gitconfig" "${HOME}"
ln -sv "${DOTFILES_DIR}/git/.gitignore_global" "${HOME}"
ln -sv "${DOTFILES_DIR}/vim/.vimrc" "${HOME}"
ln -sv "${DOTFILES_DIR}/vim/colors/" "${HOME}/.vim"
ln -sv "${DOTFILES_DIR}/lein/profiles.clj" "${HOME}/.lein"
ln -sv "${DOTFILES_DIR}/gpg/gpg-agent.conf" "${HOME}/.gnupg"
ln -sv "${DOTFILES_DIR}/sublime-text/Preferences.sublime-settings" "${HOME}/Library/Application Support/Sublime Text 3/Packages/User"

# Homebrew first for OSX dependencies
source install/brew.sh

# And now most big dependencies through brew, then language specific package managers
source install/brew-packages.sh
source install/composer.sh
source install/yarn.sh
source install/atom.sh
source install/platform.sh
source install/gpg.sh

# OSX system settings
source osx/defaults.sh
