# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

ZSH_CONFIG_DIR="$HOME/.config/zsh"

source $ZSH_CONFIG_DIR/functions.zsh
source $ZSH_CONFIG_DIR/alias.zsh
source $ZSH_CONFIG_DIR/autostart.zsh
source $ZSH_CONFIG_DIR/completion.zsh
source $ZSH_CONFIG_DIR/plugins.zsh
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
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
