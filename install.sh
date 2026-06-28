#!/usr/bin/env bash
set -ueo pipefail

lnn() {
  local p=$1
  local parent=$(dirname "$p")
  local dir=$(realpath --s --relative-to="$HOME/$parent" $PWD)
  mkdir -p "$HOME/$parent"
  [[ -L "$HOME/$p" ]] && rm "$HOME/$p"
  ln -s "$dir/$p" "$HOME/$p"
}

dlnn() {
  local place=$1
  mkdir -p "$HOME/$place"
  for ent in $place/*; do
    # lol
    if [[ "$(basename "$ent")" == "konsolerc" ]]; then
      cp "$ent" "$HOME/$ent"
    else
      lnn "$ent"
    fi
  done
}

DIR=$(realpath --s --relative-to="$HOME" $PWD)

lnn .zshrc
lnn .config/helix
lnn .config/lazygit/config.yml

if [[ -e "$HOME/.gitconfig" ]]; then
  echo "skipping gitconfig"
else
  cat > $HOME/.gitconfig << EOF
[include]
  path = $DIR/.gitconfig
EOF
fi

dlnn .icons
dlnn .local/share
