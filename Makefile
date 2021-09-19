.PHONY: base personal givedirectly symlinks brew brew_bundle osx terminal gpg_key ssh_key

base: symlinks brew_bundle terminal osx
ifeq ('',$(shell gpg --list-secret-keys | grep sec))
	$(MAKE) gpg_key
else
	@echo 'GPG key already exists'
endif
ifeq ('', $(shell find ${HOME}/.ssh -iname "*.pub"))
	$(MAKE) ssh_key
else
	@echo 'SSH key already exists'
endif

personal: base
	brew bundle --file=overrides/personal/Brewfile

givedirectly: base
	brew bundle --file=overrides/givedirectly/Brewfile

symlinks:
	# Ensure required directories exist before copying into them
	mkdir -p ${HOME}/.config/me
	mkdir -p ${HOME}/.gnupg
	mkdir -p ${HOME}/.lein
	mkdir -p ${HOME}/.stack
	mkdir -p ${HOME}/.vim
	mkdir -p ${HOME}/bin
	mkdir -p ${HOME}/Personal
	mkdir -p ${HOME}/Work

	# Symlink dotfiles
	@ln -svfn $(CURDIR)/system/.zshrc ${HOME}
	@ln -svfn $(CURDIR)/system/.inputrc ${HOME}
	@ln -svfn $(CURDIR)/system/.editorconfig ${HOME}

	@ln -svfn $(CURDIR)/git/.gitconfig ${HOME}
	@ln -svfn $(CURDIR)/git/.gitattributes ${HOME}
	@ln -svfn $(CURDIR)/git/.gitignore_global ${HOME}

	@ln -svfn $(CURDIR)/vim/.vimrc ${HOME}
	@ln -svfn $(CURDIR)/vim/colors/ ${HOME}/.vim

	@ln -svfn $(CURDIR)/.prettierrc ${HOME}

	@ln -svfn $(CURDIR)/lein/profiles.clj ${HOME}/.lein

	@ln -svfn $(CURDIR)/stack/config.yaml ${HOME}/.stack/config.yaml

	@ln -svfn $(CURDIR)/gpg/gpg-agent.conf ${HOME}/.gnupg

	# Fix gpg permissions
	chmod 600 ~/.gnupg/*
	chmod 700 ~/.gnupg

BREW_INSTALLED := $(shell command -v brew 2> /dev/null)
brew:
ifndef BREW_INSTALLED
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif

brew_bundle: brew
	brew update
	brew bundle

osx:
	# Save screenshots to Downloads
	defaults write com.apple.screencapture location -string ${HOME}/Downloads

	# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
	defaults write com.apple.screencapture type -string "png"

	# Finder: show hidden files by default
	defaults write com.apple.finder AppleShowAllFiles -bool true
	# The 'open' dialog from other programs isn't covered by the
	# above, so this global change is needed.
	defaults write -g AppleShowAllFiles -bool true

	# Finder: show all filename extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	# Finder: Display full POSIX path as window title
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

	# Avoid creating .DS_Store files on network or USB volumes
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

	# Show icons for hard drives, servers, and removable media on the desktop
	defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
	defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
	defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
	defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

	# Dock positioning
	defaults write com.apple.Dock orientation -string left
	defaults write com.apple.Dock pinning -string middle
	defaults write com.apple.Dock autohide -bool TRUE
	defaults write com.apple.dock tilesize -int 32

	# Disable bouncing dock icons
	defaults write com.apple.dock no-bouncing -bool True


	# Battery / Power Adapter - turn display off after 15 min
	sudo pmset -b displaysleep 15
	sudo pmset -c displaysleep 15

	# Battery - computer sleep after 30 min
	sudo pmset -b sleep 30

	# Power Adapter - never sleep when display is off
	sudo pmset -c sleep 0

	# Disable the sound effects on boot (requires sudo)
	sudo nvram SystemAudioVolume=" "

	# Disable UI sound effects
	defaults write 'Apple Global Domain' com.apple.sound.uiaudio.enabled -bool false

terminal:
	# Add iTerm shell integration
	@[ -f ${HOME}/.config/.iterm2_shell_integration.zsh ] || curl -L https://iterm2.com/shell_integration/zsh -o ${HOME}/.config/.iterm2_shell_integration.zsh

	# Import iTerm preferences
	@ln -svfn $(CURDIR)/iterm/com.googlecode.iterm2.plist ${HOME}/Library/Preferences

gpg_key:
	# Prompt for GPG key generation
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

# I'm going with the modern ed25519 for the moment, and supplementing it
# with an older RSA key if my workflow turns out to need it.
ssh_key:
	# Prompt for ssh key generation
	ssh-keygen -t ed25519
