# Include .profile, if it's been created by something.
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# Include all sub-components for terminals.
for DOTFILE in `find ${HOME}/dotfiles/system`
do
  [ -f "$DOTFILE" ] && source "$DOTFILE"
done
unset DOTFILE
