#! /bin/bash

emit() {
  window_class=$(hyprctl activewindow -j | jq -r .class)
  window_title=$(hyprctl activewindow -j | jq -r .title)
  if [[ "${window_class}" == *"null"* ]]; then
    echo "~"
  else
    if [ "${#window_title}" -gt 30 ]; then
      echo "${window_class} - ${window_title:0:27}..."
    else
      echo "${window_class} - ${window_title}"
    fi
  fi
}

stdbuf -oL socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
  while true; do
    read -r event
    if [[ "$event" == "activewindow>>"* ]]; then
      cornerx=$(hyprctl activewindow -j | jq -c '.at[0]')
      cornery=$(hyprctl activewindow -j | jq -c '.at[1]')
      sizex=$(hyprctl activewindow -j | jq -c '.size[0]')
      sizey=$(hyprctl activewindow -j | jq -c '.size[1]')
      centerx=$(($cornerx + $sizex / 2))
      centery=$(($cornery + $sizey / 2))
      center="$centerx,$centery"
      eww update center="$center"
      emit
    fi
  done
