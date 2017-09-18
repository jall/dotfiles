if ! is-executable brew; then
  echo "Skipping: Homebrew packages (not found: brew)"
  return
fi

# Tap required formulae first
brew tap homebrew/homebrew-php
brew tap caskroom/cask

# Make sure we're all up to date before starting
brew update
brew upgrade

# 'Smaller' cli packages first
packages=(
    composer
    git
    go
    hub
    leiningen
    php71
    pre-commit
    python3
    yarn
)

brew install "${packages[@]}"

# Now let's start the big stuff
casks=(
    atom
    caffeine
    docker
    dropbox
    firefox
    filezilla
    flux
    gogland
    google-chrome
    intellij-idea-ce
    iterm2
    java
    phpstorm
    sequel-pro
    slack
    spotify
    sublime-text
    vagrant
    virtualbox
)

brew cask install --require-sha "${casks[@]}"
