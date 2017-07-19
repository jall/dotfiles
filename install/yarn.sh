if ! is-executable yarn; then
  echo "Skipping: Yarn packages (not found: yarn)"
  return
fi

packages=(
    eslint
    eslint-cli
    prettier
    webpack
    webpack-dev-server
)

yarn global add "${packages[@]}"
