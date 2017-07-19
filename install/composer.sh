if ! is-executable composer; then
  echo "Skipping: Composer packages (not found: composer)"
  return
fi

ln -sv "${DOTFILES_DIR}/composer/composer.json" "${HOME}/.composer"
ln -sv "${DOTFILES_DIR}/composer/composer.lock" "${HOME}/.composer"

composer global install
