# Symlink dotfiles

ln -sv "${HOME}/dotfiles/.bash_profile" ~
ln -sv "${HOME}/dotfiles/.inputrc" ~
ln -sv "${HOME}/dotfiles/git/.gitconfig" ~
ln -sv "${HOME}/dotfiles/git/.gitignore_global" ~
ln -sv "${HOME}/dotfiles/vim/.vimrc" ~

# Ensure config folders exist before copying into them
mkdir -p "${HOME}/.vim/"

ln -sv "${HOME}/dotfiles/vim/colors/" ~/.vim
