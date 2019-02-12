#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo 'Es darf nur genau ein Paramter angegeben werden.'
  exit 1
fi

IFS=' |-' read -r -a words <<< "$1"

for word in "${words[@]}"; do
  firstCharacter="${word:0:1}"
  acronym+="${firstCharacter^}"
done

echo "$acronym"

exit 0
