# dotfiles

My personal dotfiles repo.

The setup is currently mostly for OSX, although many tools/config files are environment agnostic.

If you want to copy it, feel free!

# Usage

```
git clone https://github.com/jall/dotfiles.git "${HOME}/.dotfiles"
${HOME}/.dotfiles/install.sh
```

# Todo

* Atom config?

## Improvements

* Add '--force' option to install to overwrite symlinks, force update everything if possible?
    * Probably a bit dangerous for some tools - use with care
* Only install checksummed tools through brew?
* [brew services](https://github.com/Homebrew/homebrew-services) - automatically start things on login!
* Harvest nice functions from people
    * https://github.com/mathiasbynens/dotfiles/blob/master/.functions
    * http://nparikh.org/notes/zshrc.txt
* Add some more terminal auto-completions?
* Update $PATH to use brew php version by default, then allow overriding with others (like MAMP PRO) if needed
* Add tests?
* Add symlink overrides for certain brew bits?
    * `brew link --overwrite python3`
    * `brew link --overwrite php71`

## Notes

* Jetbrains IDEs
    * Settings are contained as `settings.jar` file & aren't very nice to VC.
    * No cli I can find, so settings must be imported by hand once the IDEs are installed.
* LaTeX
    * brew does not provide the simpler CLI tools like pdflatex - you have to get the whole MacTex cask, which is a 2GB install & a lot more than I currently want.

# Inspirations

* [Getting started with dotfiles](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
* [Mathias Bynens OSX settings list](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)
