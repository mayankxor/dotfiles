if [ -z "$(playerctl --all-players metadata --format ' {{title}} - {{artist}}^{{status}}' | awk -F\^ '$2 == "Playing" {print $1}')" ]; then
  exit 1
else
  playerctl --all-players metadata --format '{{duration(position)}}/{{duration(mpris:length)}}^{{status}}' 2> /dev/null | awk -F\^ '$2 == "Playing" {print $1}'
fi
