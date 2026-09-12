ZSH_CONFIG_DIR="$HOME/.config/zsh"

source $ZSH_CONFIG_DIR/functions.zsh
source $ZSH_CONFIG_DIR/alias.zsh
source $ZSH_CONFIG_DIR/autostart.zsh
source $ZSH_CONFIG_DIR/plugins.zsh
source $ZSH_CONFIG_DIR/colors.zsh
source $ZSH_CONFIG_DIR/prompt.zsh
source $ZSH_CONFIG_DIR/exports.zsh
source $ZSH_CONFIG_DIR/keybinds.zsh
source $ZSH_CONFIG_DIR/locale.zsh
source $ZSH_CONFIG_DIR/options.zsh
source $ZSH_CONFIG_DIR/secrets.zsh
source $ZSH_CONFIG_DIR/xdg.zsh

source <(fzf --zsh)
eval "$(zoxide init zsh --hook pwd )"

HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
autoload edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

source $ZSH_CONFIG_DIR/completions/init.zsh
