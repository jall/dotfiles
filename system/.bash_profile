# Include .profile, if it's been created by something.
if [ -f ~/.profile ]; then
    source ~/.profile
fi

DOTFILES="${HOME}/.dotfiles"

# Include all sub-components for terminals.
for DOTFILE in `find ${DOTFILES}/terminal`
do
  [ -f "$DOTFILE" ] && source "$DOTFILE"
done
unset DOTFILE

# This one allows for machine specific/temporary overides.
if [ -f ~/.extra ]; then
    source ~/.extra
fi

# Add git completion
source "${DOTFILES}/git/git-completion.bash"
