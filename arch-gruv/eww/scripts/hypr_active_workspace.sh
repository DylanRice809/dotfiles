socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
  while read -r event; do
    if [[ "$event" == "workspacev2>>"* ]]; then
      stripped=${event#*>>}
      printf "${stripped%%,*}"
    fi
  done
