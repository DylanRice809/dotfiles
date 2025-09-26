#! /bin/bash

slider="(scale :class \"slider\" :value {get_volume[\"volume\"]} :draw-value true :value-pos \"left\" :width 150 :min 0 :max 150 :orientation \"h\" :onchange \"pactl set-sink-volume 57 {}%\")"
label="(box :orientation \"h\" (label :class \"network\" :text \"\${get_volume[\"volume\"]}%\") (label :class \"big-sym\" :text \"\${get_volume[\"mute\"] == \"yes\" ? \"󰖁\" : \"󰕾\"}\") )"
test_label="(label :text \"TEST\")"
if [ "$1" == "hover" ]; then
  eww update volume_content="${slider}"
elif [ "$1" == "unhover" ]; then
  eww update volume_content="${label}"
else
  eww update volume_content="(label :text \"Update!\")"
fi
