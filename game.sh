#!/bin/bash

# Set text colors using tput
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
BOLD=$(tput bold)
NC=$(tput sgr0) # No Color

echo -n "what is your name? "

read name

echo hi $name

sleep 1

echo nice to meet you!

sleep 1

echo "do you want to practice typing? "

read -r -p "[y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo great!

else

  echo ok, bye!
  exit 0
fi

# Array of letters
letters=("a" "s" "d" "f" "g" "h" "j" "k" "l")

# Function to generate a random string
generate_random_string() {
  length=$1
  result=""

  for ((i = 0; i < $length; i++)); do
    index=$((RANDOM % ${#letters[@]}))
    result="${result}${letters[$index]}"
  done

  echo $result
}

# Function to get user input for word length
get_word_length() {
  PS3="Select word length (default is 5): "
  options=("3" "4" "5" "6" "7")
  echo
  select length in "${options[@]}"; do
    length=${length:-5} # Default to 5 if no option is selected
    break
  done
  echo "$length"
}

# Function to get user input for number of rounds
get_number_of_rounds() {
  PS3="Select number of rounds (default is 10): "
  options=("5" "10" "15" "20")
  echo
  select rounds in "${options[@]}"; do
    rounds=${rounds:-10} # Default to 10 if no option is selected
    break
  done
  echo "$rounds"
}

# Function to ask if the user wants to play again
ask_play_again() {
  while true; do
    read -r -p "Do you want to play again? (y/n): " response
    case $response in
    [Yy]*) return 0 ;; # User wants to play again
    [Nn]*) return 1 ;; # User does not want to play again
    *) echo "Please answer yes or no." ;;
    esac
  done
}

# Main game loop
while true; do

  # Get user input for word length and number of rounds
  word_length=$(get_word_length)
  number_of_rounds=$(get_number_of_rounds)

  score=0

  for ((count = 1; count <= $number_of_rounds; count++)); do

    # Example: generate a random string of length 5
    random_string=$(generate_random_string $word_length)

    echo

    read -r -p "Copy This: ${BOLD}${BLUE}$random_string${NC}"$'\n' answer

    if [[ "$answer" = "$random_string" ]]; then
      echo "${GREEN}Well done!${NC}"
      ((score++))
    else
      echo "${RED}Better luck next time${NC}"

    fi

    echo
  done

  # Display the final score
  # echo "Your score: $score out of $number_of_rounds"

  # Ask if the user wants to play again
  if ! ask_play_again; then
    break # Exit the loop if the user does not want to play again
  fi
done

echo "Thank you for playing!"
