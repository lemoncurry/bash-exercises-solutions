# !/usr/bin/env bash

isbn_canditate=${1?:'Es darf nur genau ein Parameter angegeben werden'}

isbnWithoutDahses="${isbn_canditate//-/}"
numberOfDigits=${#isbnWithoutDahses}

if [[ "$numberOfDigits" != 10 ]]; then
  echo 'Keine gültige ISBN-10-Nummer.'
  exit 1
fi

if [[ ! "${isbnWithoutDahses:0:9}" =~ ^[0-9]+$ ]]; then
  echo 'Keine gültige ISBN-10-Nummer.'
  exit 1
fi

declare -i sum=0 n=10

for digit in $(echo $isbnWithoutDahses | grep -o .); do
  if [[ "$digit" == 'X' ]]; then
    (( sum+=10 ))
  elif [[ ! "$digit" =~ ^[0-9]+$ ]]; then
    echo 'Keine gültige ISBN-10-Nummer.'
    exit 1
  fi
  (( sum += digit * n ))
  (( n-- ))
done

rest=$(($sum%11))

if [[ "$rest" != 0 ]]; then
  echo 'Keine gültige ISBN-10-Nummer.'
  exit 1
else
  echo 'Die angebene ISBN-10-Nummer ist gültig.'
  exit 0
fi
