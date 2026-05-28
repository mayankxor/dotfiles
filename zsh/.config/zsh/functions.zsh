# Start a process in background, fully autonomous
nohupx(){
	command nohup "$@" > /dev/null 2>&1 </dev/null &
}

# use bat to format output of commands
bat_alias(){
  local name=$1
  local lang=$2
  eval " $name() {command $name \"\$@\" | /usr/bin/bat --language=$lang --plain}"}

# fzf menu to select a process and kill it
fzfkill(){
  line="$(command ps -ef | fzf "$@" --bind 'ctrl-r:reload(ps -ef)' --header "Select Process to Kill (C-r to reload list)")"
  procid="$( echo $line | awk '{print $2}' )"
  procnameonly="$(echo $line | awk '{print $8}')"
  kill -9 $procid
  notify-send "$procnameonly was killed"
}

# fzf menu to find files and directories
fzfind(){
fd --type file |
  fzf --prompt 'Files(c-t to change)> ' \
      --bind 'ctrl-t:transform:[[ ! $FZF_PROMPT =~ Files ]] &&
              echo "change-prompt(Files(c-t to change> )+reload(fd --type file)" ||
              echo "change-prompt(Directories(c-t to change)> )+reload(fd --type directory)"' \
      --preview '[[ $FZF_PROMPT =~ Files ]] && /usr/bin/bat --color=always --number {} || tree -C {}' \
      --bind 'enter:become:[[ $FZF_PROMPT =~ Files ]] && $EDITOR {} || cd {}'
}

# fzf menu for regex search over the directory using ripgrep
fzfrg(){
	command rg --color always --line-number --no-heading "${*:-}" | fzf --ansi       --color "hl:-1:underline,hl+:-1:underline:reverse" --delimiter : --preview '/usr/bin/bat --color=always {1} --highlight-line {2}' --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' --bind 'enter:become($EDITOR {1} +{2})'
}

function y(){
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$pwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
