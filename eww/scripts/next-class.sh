day=$(date +%u)
time=$(date +%H)
done=0

cat schedule | jq -c .[$day-1] | jq -c .'classes' | jq -c '.[]' | while read i; do
  if [ $(echo $i | jq .'start') -gt $time ] && [ $done == 0 ]; then
    echo $i
    done=1
  fi
done
