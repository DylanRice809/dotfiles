#! /bin/bash

emit() {
  out='['
  active="$(hyprctl -j activeworkspace | jq .'id')"
  mapfile -t workspaces < <(hyprctl -j workspaces | jq '.[].id')
  readarray -t sorted < <(for a in "${workspaces[@]}"; do echo "$a"; done | sort)
  max="${#workspaces[@]}"
  #workspaces=($(sort <<<"${workspaces[*]}"))
  for ((i = 1; i <= $max; i++)); do
    out="$out{\"id\":\"${sorted[i - 1]}\",\"class\":"
    if [ ${sorted[i - 1]} == $active ]; then
      out="$out\"active\"},"
    else
      out="$out\"inactive\"},"
    fi
  done
  out=${out::-1}
  out="$out]"
  echo $out
}

stdbuf -oL socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
  while true; do
    read -r event
    if [[ "$event" == "workspace>>"* ]]; then
      emit
    fi
  done
