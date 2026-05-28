autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' formats ' %s(%F{red}%b%f)'
PS1='[%F{#2fc6b2}%n@%M%f %F{#2fc66c}%0~%f]${vcs_info_msg_0_}%(!.#.$) '
RPS1='%?  %* %F{green}  %f%j'
