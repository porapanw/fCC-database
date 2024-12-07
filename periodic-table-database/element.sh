#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
  exit
fi

SEARCH_NUMBER(){
  SEARCH_NUMBER_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$NUMBER")
  # if cannot find
  if [[ -z $SEARCH_NUMBER_RESULT ]]
  then
    NOT_FOUND
  else
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$NUMBER")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$NUMBER")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$NUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$NUMBER")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$NUMBER")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$NUMBER")
    FOUND
  fi
}

SEARCH_CHAR(){
  # search for symbol
  NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$CHAR'")
  # if not found
  if [[ -z $NUMBER ]]
  then
    NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$CHAR'")
    if [[ -z $NUMBER ]]
    then
      NOT_FOUND
    else
      FOUND
    fi
  else
    FOUND
  fi
}

FOUND(){
  # output if found
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$NUMBER")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$NUMBER")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$NUMBER")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
  MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$NUMBER")
  MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$NUMBER")
  BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$NUMBER")
  echo -e "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
}

NOT_FOUND(){
  # output if couldn't find
  echo -e "I could not find that element in the database."
}

SEARCHING(){
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    NUMBER=$1
    SEARCH_NUMBER
  else
    CHAR=$1
    SEARCH_CHAR
  fi
}

SEARCHING $1
