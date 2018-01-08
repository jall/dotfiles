if ! is-executable brew; then
  echo "Skipping: Homebrew packages (not found: brew)"
  return
fi

# Tap required formulae first
brew tap homebrew/homebrew-php
brew tap caskroom/cask

# Make sure we're all up to date before starting
brew update

# 'Smaller' cli packages first
packages=(
    composer
    git
    go
    gpg
    hub
    leiningen
    php71
    pinentry-mac
    pre-commit
    python3
    shellcheck
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
    hipchat
    intellij-idea-ce
    iterm2
    java
    phpstorm
    postman
    sensiblesidebuttons
    sequel-pro
    slack
    spotify
    sublime-text
    vagrant
    virtualbox
)

brew cask install --require-sha "${casks[@]}"
