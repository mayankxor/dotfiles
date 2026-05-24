# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# # Powerlevel10k instant prompt
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Load Powerlevel10k theme
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

source ~/.config/zsh/alias.zsh
source ~/.config/zsh/autostart.zsh
source ~/.config/zsh/exports.zsh
source ~/.config/zsh/functions.zsh
source ~/.config/zsh/keybinds.zsh
source ~/.config/zsh/options.zsh
source ~/.config/zsh/secrets.zsh
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/locale.zsh
source ~/.config/zsh/xdg.zsh

# Load P10K config
# [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
export _JAVA_AWT_WM_NONREPARENTING=1
# ----
source <(fzf --zsh)
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
eval "$(zoxide init zsh --hook pwd )"

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' formats ' %s(%F{red}%b%f)'

PS1='[%F{#2fc6b2}%n@%M%f %F{#2fc66c}%0~%f]${vcs_info_msg_0_}%(!.#.$) '
RPS1='%?  %* %F{green}  %f%j'
