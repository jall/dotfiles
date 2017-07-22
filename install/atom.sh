if ! is-executable apm; then
  echo "Skipping: Atom packages (not found: apm)"
  return
fi

packages=(
    atom-beautify
    atom-typescript
    busy-signal
    hyperclick
    ink
    intentions
    linter
    linter-eslint
    linter-ui-default
    lisp-paredit
    proto-repl
    react
)

installed=$( apm list --bare );

for package in "${packages[@]}"
do
   if [[ ${installed} == *"${package}"* ]]; then
       echo "Skipping: Atom package: ${package} (already installed)"
   else
       apm install "${package}"
   fi
done
