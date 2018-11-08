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

# Set up bash completion.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# This one allows for machine specific/temporary overides.
if [ -f ~/.extra ]; then
    source ~/.extra
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
