#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"


MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  # display services
  SERVICES_LIST=$($PSQL "SELECT service_id,name FROM services")
  echo "$SERVICES_LIST" | while read SERVICE_ID BAR NAME
  do
    if [[ $SERVICE_ID != service_id && $NAME != name && ! $SERVICE_ID =~ ^[-*\(*] ]]
    then
    echo -e "$SERVICE_ID) $NAME"
    fi
  done
  # choose services
  read SERVICE_ID_SELECTED
  # no service
  if [[ ! $SERVICE_ID_SELECTED =~ ^[1-5]$ ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    SEARCH_MEMBER
  fi
}

SEARCH_MEMBER(){
# ask member
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # register new member
    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      INSERT_NEW_MEMBER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      if [[ $INSERT_NEW_MEMBER_RESULT='INSERT 0 1' ]]
      then
        BOOK_SERVICE
      fi
    else
      BOOK_SERVICE
    fi
}

BOOK_SERVICE(){
  echo -e "\nWhat time would you like your cut,$CUSTOMER_NAME?"
  read SERVICE_TIME
  # add in appointment
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  echo $SERVICE_NAME
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed 's/ *//') at $SERVICE_TIME, $CUSTOMER_NAME."
}

MAIN_MENU
