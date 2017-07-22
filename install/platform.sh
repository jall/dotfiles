if ! is-executable php -o ! is-executable curl; then
  echo "Skipping: Platform.sh CLI (not found: php and/or curl)"
  return
fi

if is-executable platform; then
  echo "Already installed: Platform.sh CLI"
  return
fi

curl -sS https://platform.sh/cli/installer | php
# This makes some automatic (irritating) changes to .bash_profile,
# so let's revert those quickly.
# This should be safe because we just pulled latest code from Github.
git checkout -- "${DOTFILES}/system/.bash_profile"
