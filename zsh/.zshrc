# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="apple"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias S="cd ~/Sites"
alias I="cd ~/IdeaProjects"
# create MR for new branch in Gitlab
alias gpmr='git push -o merge_request.title="$(git symbolic-ref --short HEAD)" -o merge_request.create'

f_pdfcompress() {
    gs -sDEVICE=pdfwrite \
       -dCompatibilityLevel=1.4 \
       -dPDFSETTINGS=/ebook \
       -dNOPAUSE -dQUIET -dBATCH \
       -sOutputFile="${1}_compressed.pdf" "$1"
}
# usage: pdfcompress original.pdf
alias pdfcompress='f_pdfcompress'

f_pdfoptimize() {
    gs -sDEVICE=pdfwrite \
       -dCompatibilityLevel=2.0 \
       -sPDFSETTINGS="$1" \
       -dDetectDuplicateImages=true \
       -dRemoveUnusedResources=true \
       -dCompressFonts=true \
       -dSubsetFonts=true \
       -dNOPAUSE -dQUIET -dBATCH \
       -sOutputFile="${2}_optimized.pdf" "${2}"
}
# Usage: pdfoptimize preset input.pdf
# Presets: /screen /ebook /printer /prepress
# pdfoptimize /ebook large_document.pdf
alias pdfoptimize='f_pdfoptimize'

alias heic2jpg='for file in *.HEIC; do magick "$file" "${file%.HEIC}.jpg" && echo "Converted $file to ${file%.HEIC}.jpg"; done'

export NVM_DIR="$HOME/.nvm"
if [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]; then
  \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm (macOS Homebrew)
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
elif [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh" # This loads nvm (Linux)
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi


autoload -U add-zsh-hook
load-nvmrc() {
local nvmrc_path="$(nvm_find_nvmrc)"

if [ -n "$nvmrc_path" ]; then
local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
echo "Reverting to nvm default version"
nvm use default
fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# node_updater.sh
#
# This script makes keeping NVM-managed NodeJS and its global packages up-to-date a breeze.
# Requires nvm, the Node Version Manager (https://github.com/creationix/nvm)
# 
# First load it: _$: touch node_updater.sh
# Then run it: node_updater
#
# Protip: Add to your .bash_profile for hassle-free updating.
#

node_updater () {
    export NODE_CURRENT=$(nvm_ls_current)
    export NODE_LATEST=$(nvm_remote_versions | grep '^v' | tail -1)

    # Update global NodeJS to 'latest'. Migrates all installed global packages into the new Version.
    echo "Updating global NodeJS installation from ${NODE_CURRENT} to ${NODE_LATEST}."
    nvm install ${NODE_LATEST} --reinstall-packages-from=${NODE_CURRENT} && echo "Upgrade of global NodeJS installation complete."

    # Remove previous NodeJS versions
    nvm use ${NODE_LATEST}

    # Update global NodeJS packages to 'latest'
    for PACKAGE in $(npm --global outdated --parseable --depth=0 --loglevel silent | cut -d: -f3 | cut -f1 -d'@');
        do npm --global install --loglevel silent ${PACKAGE} && echo "Updated global package '${PACKAGE}' to 'latest'.";
    done

    # Uncomment to delete previous NodeJS  installations after update
    #find ${NVM_DIR}/versions/node -type d -mindepth 1 -maxdepth 1 -not -name ${NODE_LATEST} -exec sh -c 'printf "Removed NodeJS version: "' \; -exec basename {} \; -exec rm -r {} \;
}

# This line adds directories to the system's PATH:
# 1. $HOME/bin: Adds the user's personal bin directory
# 2. $HOME/.codeium/windsurf/bin: Adds Codeium's Windsurf binary directory
# Both are prepended to ensure they take precedence over system directories
export PATH="$HOME/bin:$HOME/.codeium/windsurf/bin:$PATH"

# Load machine-specific configurations if they exist
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local

# uv python manager (Linux install script path, no-op on macOS Homebrew)
[ -s "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"

[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

eval "$(mcfly init zsh)"
eval "$(zoxide init zsh)"
