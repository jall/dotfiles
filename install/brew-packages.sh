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
    git
    go
    hub
    yarn
    php71
    composer
    leiningen
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
    iterm2
    phpstorm
    sequel-pro
    spotify
)

brew cask install "${casks[@]}"
