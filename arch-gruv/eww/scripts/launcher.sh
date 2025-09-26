#! /bin/bash

out="["

for file in /usr/share/applications/*.desktop; do
  if [[ $(cat $file | grep 'NoDisplay=true') == "NoDisplay=true" ]]; then
    continue
  fi

  if [ $file == "/usr/share/applications/steam.desktop" ]; then
    name="steam"
    exec="/usr/bin/steam"
    icon="steam"
  else
    name=$(cat $file | grep -Po '(?<=^Name=)\S+' | tr ' ' '\n' | awk '!a[$0]++')
    exec=$(cat $file | grep -Po '(?<=^Exec=)\S+' | tr ' ' '\n' | awk '!a[$0]++')
    icon=$(cat $file | grep -Po '(?<=^Icon=)\S+' | tr ' ' '\n' | awk '!a[$0]++')
  fi

  out="$out{\"name\":\"$name\",\"exec\":\"$exec\",\"icon\":\"$icon\"},"
done

out="${out::-1}]"
echo $out
