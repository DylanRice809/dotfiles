vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o -P '\d+%' | head -1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -P -o '(?<=Mute: )[a-z]\w+' | head -1)
vol=${vol::-1}
echo "{\"volume\":\"$vol\",\"mute\":\"$mute\"}"
