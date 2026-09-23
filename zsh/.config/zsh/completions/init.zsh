autoload -Uz +X compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

load_completions=(
  herdr
  grok
  delta
  )

for cmd in $load_completions; do
    if (( $+commands[$cmd] )); then
      source "$ZSH_CONFIG_DIR/completions/_$cmd.zsh"
    fi
done
