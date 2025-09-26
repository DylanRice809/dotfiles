#! /bin/bash

mapfile -t networks < <(nmcli -t -f NAME connection show --active)

out="{\"name\":\""

if [[ "${#networks[0]}" -gt 11 ]]; then
  out="$out${networks[0]:0:8}...\"}"
else
  out="$out${networks[0]}\"}"
fi

strength=$(nmcli -terse -fields SIGNAL,ACTIVE device wifi |
  awk --field-separator ':' '{if($2=="yes")print$1}')

echo $out
