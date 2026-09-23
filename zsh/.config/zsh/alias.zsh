alias ls="ls --color=auto"
alias l="ls --color=auto -l"
alias la="ls --color=auto -l --almost-all"
alias lh="ls --color=auto -l --human-readable"
alias lha='ls --color=auto -l --human-readable --almost-all'
alias diff="diff --color=auto --show-c-function  --tabsize=2 --recursive"
alias cd..="cd .."
alias nohup=nohupx
alias grep="grep --color --with-filename --line-number"

alias gs="git status"
alias gl="git log --all --graph --pretty=format:'commit: %C(magenta)%h %C(auto) %C(auto)%d%n%C(auto)Author: %C(white)%an <%C(cyan)%ae%C(auto)>%nTime  : %aD %at - %ar%n%n%C(always,bold green)%B'"
alias gc="git commit"
alias ga="git add"
alias gp="git push"
alias gpu="git pull"
alias gsh="git show"
alias gb="git branch"
alias gcl="git clone"
alias gi="git init"
alias gd="git diff"

alias yt="yt-dlp -S res:720,+size"

if (( $+commands[bat] ));then
  bat_alias lsblk conf
  bat_alias free cpuinfo
  bat_alias ps log
fi
