.PHONY: all symlinks brew brew_bundle composer yarn platform osx gpg

all: symlinks brew_bundle composer yarn osx
ifeq ('',$(gpg --list-secret-keys | grep sec))
	# We only run GPG key gen on install if one doesn't exist yet.
	$(MAKE) gpg
endif

SUBLIME_USER_DIR := ${HOME}/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
symlinks:
	# Ensure required directories exist before copying into them
	mkdir -p ${HOME}/.vim/
	mkdir -p ${HOME}/.lein/
	mkdir -p ${HOME}/.gnupg/
	mkdir -p ${HOME}/bin/
	mkdir -p ${HOME}/Personal/
	mkdir -p ${HOME}/Personal/go
	mkdir -p ${HOME}/Work/

	# Symlink dotfiles
	@ln -svfn $(CURDIR)/system/.bash_profile ${HOME}
	@ln -svfn $(CURDIR)/system/.inputrc ${HOME}
	@ln -svfn $(CURDIR)/system/.editorconfig ${HOME}

	@ln -svfn $(CURDIR)/git/.gitconfig ${HOME}
	@ln -svfn $(CURDIR)/git/.gitignore_global ${HOME}

	@ln -svfn $(CURDIR)/vim/.vimrc ${HOME}
	@ln -svfn $(CURDIR)/vim/colors/ ${HOME}/.vim

	@ln -svfn $(CURDIR)/lein/profiles.clj ${HOME}/.lein

	@ln -svfn $(CURDIR)/gpg/gpg-agent.conf ${HOME}/.gnupg

	@ln -svfn $(CURDIR)/sublime-text/Preferences.sublime-settings ${SUBLIME_USER_DIR}
	@ln -svfn $(CURDIR)/sublime-text/Package\ Control.sublime-settings ${SUBLIME_USER_DIR}

	@ln -svfn $(CURDIR)/composer/composer.json ${HOME}/.composer
	@ln -svfn $(CURDIR)/composer/composer.lock ${HOME}/.composer

BREW_INSTALLED := $(shell command -v brew 2> /dev/null)
brew:
ifndef BREW_INSTALLED
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif

brew_bundle: brew
	brew update
	brew bundle

composer: brew_bundle
	composer global install

yarn: brew_bundle
	yarn global add eslint eslint-cli prettier webpack webpack-dev-server

PLATFORM_INSTALLED := $(shell command -v platform 2> /dev/null)
platform: brew_bundle
ifndef PLATFORM_INSTALLED
	curl -sS https://platform.sh/cli/installer | php
	# This has made some automatic (irritating) changes to .bash_profile,
	# so let's revert those.
	git checkout -- $(CURDIR)/system/.bash_profile
endif

osx:
	# Save screenshots to the desktop
	@defaults write com.apple.screencapture location -string ${HOME}/Desktop

	# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
	@defaults write com.apple.screencapture type -string "png"

	# Finder: show hidden files by default
	@defaults write com.apple.finder AppleShowAllFiles -bool true
	# The 'open' dialog from other programs isn't covered by the
	# above, so this global change is needed.
	@defaults write -g AppleShowAllFiles -bool true

	# Finder: show all filename extensions
	@defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	# Finder: Display full POSIX path as window title
	@defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

	# Avoid creating .DS_Store files on network or USB volumes
	@defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	@defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

	# Show icons for hard drives, servers, and removable media on the desktop
	@defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
	@defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
	@defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
	@defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

	# Disable the sound effects on boot (requires sudo)
	@sudo nvram SystemAudioVolume=" "

gpg:
	# Prompt for key generation
	gpg --full-generate-key --expert

	@echo "Please restart your computer to enable pinentry-mac."
	@echo "Once active, pinentry-mac will prompt for your key's"
	@echo "passphrase the next time you attempt to sign with it.";
	@echo "Choose 'Save to Keychain' to store your passphrase in OSX's Keychain."
	@echo "This allows automatic signing without prompting for the passphrase continually.";
	@echo "";
	@echo "You may also want to add your key to your local git config (~/.gitconfig_local).";
	@echo "This allows for automatic GPG signing of every commit/tag you make.";
	@echo "";
	@echo "You may also want to add your GPG key to Github."
	@echo 'You can view instructions on how to do this here:'
	@echo 'https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account'
