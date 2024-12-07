#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

ASK_FOR_NUMBER(){
  read NUMBER
  if [[ ! $NUMBER =~ ^[0-9]+*$ ]]
  then
    echo -e "That is not an integer, guess again:"
    ((NUMBER_OF_GUESSES++))
    ASK_FOR_NUMBER
  fi
}

ENDED(){
  # update games_played
  ((GAMES_PLAYED++))
  UPDATE_GAMES_PLAYED=$($PSQL "UPDATE userdata SET games_played=$GAMES_PLAYED WHERE username='$USERNAME'")
  # update best_game
  BEST_GAME=$(echo $($PSQL "SELECT best_game FROM userdata WHERE username='$USERNAME'") | sed 's/ //g')
  # echo $NUMBER_OF_GUESSES
  if [[ -z $BEST_GAME || $BEST_GAME -eq 0 || $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
  then
    UPDATE_BEST_GAME=$($PSQL "UPDATE userdata SET best_game=$NUMBER_OF_GUESSES WHERE username='$USERNAME'")
  fi
  # print result
  echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
}

COMPARE(){
  # if correct
  if [[ $SECRET_NUMBER -eq $NUMBER ]]
  then
    ((NUMBER_OF_GUESSES++))
    ENDED
  # if incorrect
  elif [[ $SECRET_NUMBER -gt $NUMBER ]]
  then
    ((NUMBER_OF_GUESSES++))
    echo -e "This is your $NUMBER_OF_GUESSES tries"
    echo -e "It's higher than that, guess again:"
    ASK_FOR_NUMBER
    COMPARE
  else
    ((NUMBER_OF_GUESSES++))
    echo -e "This is your $NUMBER_OF_GUESSES tries"
    echo -e "It's lower than that, guess again:"
    ASK_FOR_NUMBER
    COMPARE
  fi
}
  
GUESSING_GAME(){
  SECRET_NUMBER=$(( 1 + RANDOM % 1000 ))
  echo -e "Guess the secret number between 1 and 1000:"
  NUMBER_OF_GUESSES=0
  # for debug
  echo $SECRET_NUMBER
  ASK_FOR_NUMBER
  COMPARE  
}

# start
ASK_USERNAME(){
  echo Enter your username:
  read USERNAME
  if [[ ${#USERNAME} -gt 22 ]]
  then
    ASK_USERNAME
  fi
}

ASK_USERNAME
USER_ID=$(echo $($PSQL "SELECT user_id FROM userdata WHERE username='$USERNAME'") | sed 's/ //g')
# if cannot find
if [[ -z $USER_ID ]]
then
  INSERT_DATA=$($PSQL "INSERT INTO userdata(username,games_played) VALUES('$USERNAME',0)")
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
  GUESSING_GAME
# if found
else
  GAMES_PLAYED=$(echo $($PSQL "SELECT games_played FROM userdata WHERE username='$USERNAME'") | sed 's/ //g')
  BEST_GAME=$(echo $($PSQL "SELECT best_game FROM userdata WHERE username='$USERNAME'") | sed 's/ //g')
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  GUESSING_GAME
fi
