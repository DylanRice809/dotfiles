#! /bin/bash

mapfile -t networks < <(nmcli -f SSID dev wifi)
out="["
SSIDS=()

for ((i = 1; i <= (${#networks[@]} - 1); i++)); do
  SSID=${networks[i]}
  SSID="${SSID#"${SSID%%[![:space:]]*}"}"
  SSID="${SSID%"${SSID##*[![:space:]]}"}"
  if [ "$SSID" != "--" ]; then
    SSIDS=("${SSIDS[@]}" "$SSID")
  fi
done

sorted=()
for ((i = 0; i < ${#SSIDS[@]}; i++)); do
  found=0
  for ((j = 0; j < ${#sorted[@]}; j++)); do
    if [ "${SSIDS[$i]}" == "${sorted[$j]}" ]; then
      found=1
    fi
  done
  if [ $found == 0 ]; then
    sorted=("${sorted[@]}" "${SSIDS[$i]}")
  fi
done

for ((i = 0; i < ${#sorted[@]}; i++)); do
  out="$out{\"SSID\":\"${sorted[$i]}\"},"
done

out=${out::-1}
out="$out]"
echo $out
