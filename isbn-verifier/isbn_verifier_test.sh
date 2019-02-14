#!/usr/bin/env bash

@test 'valid isbn number' {
  run bash isbn_verifier.sh '3-598-21508-8'
  [ "$status" -eq 0 ]
  [ "$output" == 'Die angebene ISBN-10-Nummer ist gültig.' ]
}

@test 'invalid isbn check digit' {
  run bash isbn_verifier.sh '3-598-21508-9'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'valid isbn number with a check digit of 10' {
  run bash isbn_verifier.sh '3-598-21507-X'
  [ "$status" -eq 0 ]
  [ "$output" == 'Die angebene ISBN-10-Nummer ist gültig.' ]
}

@test 'check digit is a character other than X' {
  run bash isbn_verifier.sh '3-598-21507-A'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'invalid character in isbn' {
  run bash isbn_verifier.sh '3-598-P1581-X'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'X is only valid as a check digit' {
  run bash isbn_verifier.sh '3-598-2X507-9'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'valid isbn without separating dashes' {
  run bash isbn_verifier.sh '3598215088'
  [ "$status" -eq 0 ]
  [ "$output" == 'Die angebene ISBN-10-Nummer ist gültig.' ]
}

@test 'isbn without separating dashes and X as check digit' {
  run bash isbn_verifier.sh '359821507X'
  [ "$status" -eq 0 ]
  [ "$output" == 'Die angebene ISBN-10-Nummer ist gültig.' ]
}

@test 'isbn without check digit and dashes' {
  run bash isbn_verifier.sh '359821507'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'too long isbn and no dashes' {
  run bash isbn_verifier.sh '3598215078X'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'too short isbn' {
  run bash isbn_verifier.sh '00'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'isbn without check digit' {
  run bash isbn_verifier.sh '3-598-21507'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'check digit of X should not be used for 0' {
  run bash isbn_verifier.sh '3-598-21515-X'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'empty isbn' {
  run bash isbn_verifier.sh ''
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'input is 9 characters' {
  run bash isbn_verifier.sh '134456729'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'invalid characters are not ignored' {
  run bash isbn_verifier.sh '3132P34035'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}

@test 'input is too long but contains a valid isbn' {
  run bash isbn_verifier.sh '98245726788'
  [ "$status" -eq 1 ]
  [ "$output" == 'Keine gültige ISBN-10-Nummer.' ]
}
