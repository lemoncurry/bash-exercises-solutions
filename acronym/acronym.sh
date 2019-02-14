#!/usr/bin/env bash

phrase=${1?:'Es darf nur genau ein Parameter angegeben werden'}

IFS=' |-' read -r -a words <<< "$phrase"

for word in "${words[@]}"; do
  firstCharacter="${word:0:1}"
  acronym+="${firstCharacter^}"
done

echo "$acronym"
exit 0
