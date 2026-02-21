typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Powerlevel10k theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

autoload -Uz compinit && compinit

source ~/.config/zsh/alias.zsh
source ~/.config/zsh/autostart.zsh
source ~/.config/zsh/exports.zsh
source ~/.config/zsh/functions.zsh
source ~/.config/zsh/keybinds.zsh
source ~/.config/zsh/options.zsh
source ~/.config/zsh/secrets.zsh
source ~/.config/zsh/style.zsh
source ~/.config/zsh/locale.zsh

# Load P10K config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ----
source <(fzf --zsh)
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

colorscript --random 

