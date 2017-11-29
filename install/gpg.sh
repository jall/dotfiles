if ! is-executable gpg; then
  echo "Skipping: GPG key check/generation (not found: gpg)"
  return
fi

# If at least one key already exists, don't bother
# prompting to generate a new key.
if [[ $(gpg --list-secret-keys | grep sec) ]]; then
    echo "Skipping: GPG key generation (at least one key already exists)"
    return
fi

# Prompt for key generation
gpg --full-generate-key

echo "Please restart your computer to enable pinentry-mac."
echo "Once active, pinentry-mac will prompt for your key's"
echo "passphrase the next time you attempt to sign with it.";
echo "Choose 'Save to Keychain' to store your passphrase in OSX's Keychain."
echo "This allows automatic signing without prompting for the passphrase continually.";

echo "";

echo "You may also want to add your key to your local git config (~/.gitconfig_local).";
echo "This allows for automatic GPG signing of every commit/tag you make.";

echo "";

echo "You may also want to add your GPG key to Github."
echo 'You can view instructions on how to do this here:'
echo 'https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account'
