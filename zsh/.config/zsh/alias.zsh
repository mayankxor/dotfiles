alias ls="ls --color=auto"
alias l="ls --color=auto -l"
alias la="ls --color=auto -l --all"
alias nohup=nohupx

bat_alias() {
  local name=$1
  local lang=$2

  eval "
  $name() {
    command $name \"\$@\" | /usr/bin/bat --language=$lang --plain
  }
  "
}

bat_alias lsblk conf
bat_alias free cpuinfo
bat_alias ps log

