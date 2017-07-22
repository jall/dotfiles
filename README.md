# dotfiles

My personal dotfiles repo.

The setup is currently mostly for OSX, although many tools/config files are environment agnostic.

If you want to copy it, feel free!

# Usage

```
git clone https://github.com/jall/dotfiles.git "${HOME}/dotfiles"
${HOME}/dotfiles/install.sh
```

# Todo

## Install

* phpStorm/gogland plugins?
* phpStorm/gogland settings?
* LaTeX?

## Improvements

* Only install checksummed tools through brew?
* [brew services](https://github.com/Homebrew/homebrew-services) - automatically start things on login!
* Comment EVERYTHING
    * .inputrc
* Harvest nice functions from people
    * https://github.com/mathiasbynens/dotfiles/blob/master/.functions
    * http://nparikh.org/notes/zshrc.txt
* Add some more terminal auto-completions?
* Update $PATH to use brew php version by default, then allow overriding with others (like MAMP PRO) if needed
* Add tests?
* Add symlink overrides for certain brew bits?
    * `brew link --overwrite python3`
    * `brew link --overwrite php71`

# Inspirations

* [Getting started with dotfiles](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
* [Mathias Bynens OSX settings list](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)
