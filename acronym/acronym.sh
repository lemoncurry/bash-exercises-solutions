#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo 'Es darf nur genau ein Paramter angegeben werden.'
  exit 1
fi

phrase="$1"

IFS=' |-' read -r -a words <<< "$phrase"

for word in "${words[@]}"; do
  firstLetterUppercase="${word^}"
  firstCharacter="${firstLetterUppercase:0:1}"
  acronym+="$firstCharacter"
done

echo "$acronym"

exit 0
