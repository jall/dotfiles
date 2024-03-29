# dotfiles

My personal dotfiles repo.

The setup is for OSX, although many tools/config files are environment agnostic.

If you want to copy it, feel free!

## Usage

First install Xcode to get git and some basic bits

```sh
xcode-select --install
```

Pull this repo

```sh
git clone https://github.com/jall/dotfiles.git "${HOME}/.dotfiles"
cd ${HOME}/.dotfiles
```

Run the appropriate make commands

```sh
make base
make personal
make $WORKPLACE
```

### Git

My git setup accepts an (optional) `~/.gitconfig_local` file which can be used for machine specific overrides. This is generally used to swap out the email for a work one, or adding a specific GPG signing key to use.

E.g. adding

```sh
[user]
    email = jon@currentemployer.com
```

will override the email my commits are signed with on this machine.

### GPG

If no GPG key exists on this machine, generate a new one.

```sh
make gpg_key
```

[Github has good instructions](https://help.github.com/articles/generating-a-new-gpg-key) on what details to enter. For key type, RSA is standard & works everywhere, but elliptic curves are potentially stronger/faster/more future proof (probably want Curve 25519 or NIST P-521).

**Make sure to store the passphrase in keychain/a password manager.**

After this, add the new key id to local git config (`~/.gitconfig_local`) to enable automatic commit/tag signing with these parameters:

```sh
[user]
    signingkey = MY_KEY_ID
[commit]
    gpgsign = true

```

Then [upload the public key to Github](https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account) so commits are verified as coming from me. **This only works if the email in the GPG key and Github profile match.**

For automatic signing, the `pinentry-mac` program can be used. This will pop up when GPG asks for the key passphrase (e.g. when signing a commit), and the passphrase can then be stored in the OSX keychain so it's automatically used from that point on when signed in.

## Todo

- enable filevault
- swap flux to NightShift
- [Calva](https://calva.io/) for Clojure, instead of Cursive/Intellij
- [Look into using GNU Stow for managing symlinks](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
- Use `add_to_path` function for .path?

## Improvements

- [brew services](https://github.com/Homebrew/homebrew-services) - automatically start things on login!
- Harvest nice bits from people
  - https://github.com/mattbrictson/dotfiles
  - https://github.com/jessfraz/dotfiles
- Tests
- Add OSX defaults
  - Desktop view 'snap to grid'
  - Login items (will brew services do this?)
  - Docker for Mac
  - Slack
- Add `GH_TOKEN` notes, or add generator to Makefile

## Notes

- LaTeX
  - brew does not provide the simpler CLI tools like pdflatex - you have to get the whole MacTex cask, which is a 2GB install & a lot more than I currently want.

## Inspirations

- [Getting started with dotfiles](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
- [Mathias Bynens OSX settings list](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)
