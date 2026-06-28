# This cleans things up *so much*
try() {
  [ -r "$1" ] && source "$1" ${@:2}
}

# p10k instant prompt
try "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# OMZ
export ZSH="$HOME/.oh-my-zsh"
# Use p10k local if it exists, default to ok theme otherwise
[ -d $ZSH/custom/themes/powerlevel10k/ ] && ZSH_THEME="powerlevel10k/powerlevel10k" || ZSH_THEME="robbyrussell"
plugins=(git)
try $ZSH/oh-my-zsh.sh

# Global p10k theme, only if there's no local
[ "$ZSH_THEME" != "powerlevel10k/powerlevel10k" ] && try /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# p10k config
try $HOME/.p10k.zsh

# zoxide
which zoxide >/dev/null && eval "$(zoxide init zsh)"

# nvm
try /usr/share/nvm/init-nvm.sh

# Nintendo systems toolchain thing
try /etc/profile.d/devkit-env.sh
 
# Arch doesn't set this by default
export XDG_CONFIG_HOME="$HOME/.config"
# Language package manager binaries
PATH="$HOME/.local/bin/:$PATH"

# Use secret service for git credentials
export GCM_CREDENTIAL_STORE=secretservice

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Go
export PATH="$HOME/go/bin:$PATH"

if which hx >/dev/null; then
  # Helix whoo
  export VISUAL=hx
  export EDITOR=hx
fi

# Build envs
export CC=clang
export CXX=clang++

# Use all processors when using `make`
export MAKEFLAGS="-j$(($(nproc) + 1))"
export CMAKE_GENERATOR=Ninja

# Dart CLI
try $HOME/.config/.dart-cli-completion/zsh-config.zsh

# For Android-related stuff
[ -d $HOME/Android/Sdk ] && export ANDROID_HOME=$HOME/Android/Sdk

# dotnet
export PATH="$HOME/.dotnet/tools:$PATH"
alias l="ls -lAh"

# No history rotation
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Conda
try /opt/miniconda3/etc/profile.d/conda.sh

# Use Wayland for SDL
export SDL_VIDEODRIVER=wayland
