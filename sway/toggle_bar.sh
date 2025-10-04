curr_mode=$(swaymsg -t get_bar_config mainbar | jq ".mode")

if [[ $curr_mode == '"dock"' ]]; then
  swaymsg bar mainbar mode invisible
else
  swaymsg bar mainbar mode dock
fi
