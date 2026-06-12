line="$(playerctl --all-players metadata --format ' {{title}} - {{artist}}^{{status}}' | awk -F\^ '$2 == "Playing" {print $1}')"
if [ -z "$line" ]; then
  exit 1
else
  echo "$line"
fi
