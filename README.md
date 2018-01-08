# dotfiles

My personal dotfiles repo.

The setup is currently mostly for OSX, although many tools/config files are environment agnostic.

If you want to copy it, feel free!

# Usage

```
git clone https://github.com/jall/dotfiles.git "${HOME}/.dotfiles"
${HOME}/.dotfiles/install.sh
```

## Git

My git setup accepts an (optional) `~/.gitconfig_local` file which can be used for machine specific overrides. This is generally used to swap out the email for a work one, or adding a specific GPG signing key to use.

E.g. adding
```
[user]
    email = jon@currentemployer.com
```
will override the email my commits are signed with on this machine.

## GPG

If no GPG key exists on this machine, generate a new one.
```
gpg --full-generate-key
```
Follow the [Github instructions](https://help.github.com/articles/generating-a-new-gpg-key) what details to enter.

**Make sure to store the passphrase in keychain/a password manager.**

After this, add the new key id to local git config (`~/.gitconfig_local`) to enable automatic commit/tag signing with these parameters:
```
[user]
    signingkey = MY_KEY_ID
[commit]
    gpgsign = true

```

Then [upload the public key to Github](https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account) so commits are verified as coming from me. **This only works if the email in the GPG key and Github profile match.**

For automatic signing, the `pinentry-mac` program can be used. This will pop up when GPG asks for the key passphrase (e.g. when signing a commit), and the passphrase can then be stored in the OSX keychain so it's automatically used from that point on when signed in.

# Todo

* Remove Atom in favour of Sublime

## Improvements

* Add '--force' option to install to overwrite symlinks, force update everything if possible?
    * Probably a bit dangerous for some tools - use with care
* [brew services](https://github.com/Homebrew/homebrew-services) - automatically start things on login!
* Harvest nice bits from people
    * https://github.com/mattbrictson/dotfiles
* Add some more terminal auto-completions?
* Update $PATH to use brew php version by default, then allow overriding with others (like MAMP PRO) if needed
* Add tests?
* Add symlink overrides for certain brew bits?
    * `brew link --overwrite python3`
    * `brew link --overwrite php71`
* Add .extra file for machine specific overrides, as per [jessfraz](https://github.com/jessfraz/dotfiles).
* Sublime Text 3 packages
* [Brewfile](https://github.com/Homebrew/homebrew-bundle) rather than shell script
* Check out [mas](https://github.com/mas-cli/mas) for Mac App Store dependencies.
* Update php to 7.2?


## Notes

* Jetbrains IDEs
    * Settings are contained as `settings.jar` file & aren't very nice to VC.
    * No cli I can find, so settings must be imported by hand once the IDEs are installed.
* LaTeX
    * brew does not provide the simpler CLI tools like pdflatex - you have to get the whole MacTex cask, which is a 2GB install & a lot more than I currently want.

# Inspirations

* [Getting started with dotfiles](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
* [Mathias Bynens OSX settings list](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)
