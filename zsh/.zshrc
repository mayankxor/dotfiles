# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

source ~/.config/zsh/functions.zsh
source ~/.config/zsh/alias.zsh
source ~/.config/zsh/autostart.zsh
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/exports.zsh
source ~/.config/zsh/keybinds.zsh
source ~/.config/zsh/locale.zsh
source ~/.config/zsh/options.zsh
source ~/.config/zsh/prompt.zsh
source ~/.config/zsh/secrets.zsh
source ~/.config/zsh/xdg.zsh

source <(fzf --zsh)
eval "$(zoxide init zsh --hook pwd )"

HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
