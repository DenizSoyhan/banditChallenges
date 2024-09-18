#!/usr/bin/bash

# Define the character to use for the rating representation
char="▉"

# Number of characters per rating point
points_per_char=5

# Color codes
color_red="\e[31m"
color_green="\e[32m"
color_orange="\e[33m"
color_blue="\e[34m"
color_reset="\e[0m"

# Initialize variables
level=""
rating=""
review=""

echo -e "\e[36\nmRatingler 0-20 arasındadır. 20 imkansız, 0 kendi kendini çözdü demek\n\e[0m"

# Process each line in the file
while IFS= read -r line; do
    # Skip empty lines
    if [[ -z "$line" ]]; then
        continue
    fi

    # Process level and rating
    if [[ -z "$rating" ]]; then
        # Read level and rating
        if [[ "$line" =~ ^[0-9]+:[0-9]+ ]]; then
            level=$(echo "$line" | awk -F':' '{print $1}')
            rating=$(echo "$line" | awk -F':' '{print $2}')
        fi
    else
        # Read review
        review=$(echo "$line" )
        # Check if review is enclosed in quotes

        # Determine color based on rating
        if (( rating >= 0 && rating <= 2 )); then
            color="$color_blue"
        elif (( rating >= 2 && rating <= 4 )); then
            color="$color_green"
        elif (( rating >= 5 && rating <= 7 )); then
            color="$color_orange"
        elif (( rating >= 8)); then
            color="$color_red"
        else
            color="$color_reset"  # Default color
        fi
        # Calculate the number of characters to print
        chars=$(printf "%.s$char" $(seq 1 $((rating * points_per_char))))

        # Print level, rating, and review with color
        if ((rating>=10));then
            printf "${color}Level: %s Rating: %s %s\nReview: %s\n\n${color_reset}" "$level" "$rating" "$chars" "$review"
        else
            printf "Level: %s Rating: %s ${color}%s${color_reset}\nReview: %s\n\n" "$level" "$rating" "$chars" "$review"
        fi
        # Reset variables for the next entry
        level=""
        rating=""
        review=""
    fi
done < review.txt

#▉▉
#▀ 	▁ 	▂ 	▃ 	▄ 	▅ 	▆ 	▇ 	█ 	▉ 	▊ 	▋ 	▌ 	▍ 	▎ 	▏
#U+259x 	▐ 	░ 	▒ 	▓ 	▔ 	▕ 	▖ 	▗ 	▘ 	▙ 	▚ 	▛ 	▜ 	▝ 	▞ 	▟