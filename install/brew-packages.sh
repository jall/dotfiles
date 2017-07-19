if ! is-executable brew; then
  echo "Skipping: Homebrew packages (not found: brew)"
  return
fi

# Tap required formulae first
brew tap homebrew/homebrew-php

# Make sure we're all up to date before starting
brew update
brew upgrade

apps=(
    git
    go
    hub
    yarn
    php71
    composer
)

brew install "${apps[@]}"
