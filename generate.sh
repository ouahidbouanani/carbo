#!/bin/bash

START="2025-08-01"
END="2025-09-30"

current=$START

while [ "$(date -d "$current" +%Y%m%d)" -le "$(date -d "$END" +%Y%m%d)" ]
do
  day_of_week=$(date -d "$current" +%u)

  if [ "$day_of_week" -ne 7 ]; then
    
    commits=$((RANDOM % 6 + 1))

    for ((i=1;i<=commits;i++))
    do
      time=$(printf "%02d:%02d:00" $((RANDOM%23)) $((RANDOM%59)))
      datetime="$current"T"$time"

      echo "$datetime" >> activity.txt
      git add activity.txt

      GIT_AUTHOR_DATE="$datetime" \
      GIT_COMMITTER_DATE="$datetime" \
      git commit -m "update $datetime"

    done
  fi

  current=$(date -I -d "$current + 1 day")
done