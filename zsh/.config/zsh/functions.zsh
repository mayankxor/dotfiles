nohupx(){
	command nohup "$@" > /dev/null 2>&1 </dev/null &
}

fzfkill(){
	command ps -ef | fzf "$@" --bind 'ctrl-r:reload(ps -ef)' --header "Select Process to Kill (C-r to reload list)" | awk '{print $2}' | xargs kill -9
}

fzfind(){
fd --type file |
  fzf --prompt 'Files> ' \
      --bind 'ctrl-t:transform:[[ ! $FZF_PROMPT =~ Files ]] &&
              echo "change-prompt(Files> )+reload(fdfind --type file)" ||
              echo "change-prompt(Directories> )+reload(fdfind --type directory)"' \
      --preview '[[ $FZF_PROMPT =~ Files ]] && /usr/bin/bat --color=always --number {} || tree -C {}'
}

fzfrg(){
	command rg --color always --line-number --no-heading "${*:-}" | fzf --ansi       --color "hl:-1:underline,hl+:-1:underline:reverse" --delimiter : --preview '/usr/bin/bat --color=always {1} --highlight-line {2}' --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' --bind 'enter:become(nvim {1} +{2})'
}

function y(){
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$pwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
