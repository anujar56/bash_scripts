#!/bin/bash

# Function to display help message
show_help() {
    echo "Usage: ./calculate_area.sh [-h] [-i] [--debug] [--logfile filename] [shape dimensions]"
    echo
    echo "Calculate the area of various geometric shapes."
    echo 
    echo "Options:"
    echo "-h Display this help message."
    echo "-i Interactive mode."
    echo "--debug Enable detailed debug logging."
    echo "--logfile Specify the file to log to."
    echo
    echo "Shapes:"
    echo "circle radius Calculate the area of a circle."
    echo "square side Calculate the area of a square."
    echo "rectangle length width Calculate the area of a rectangle."
}

# Function to handle interactive area calculation
cal() {
    echo "Select the type of area to calculate:"
    echo "1. Circle"
    echo "2. Square"
    echo "3. Rectangle"
    echo "Enter choice:"
    read choice

    case $choice in
        1)
            local pi="3.14159"
            read -p "Enter the radius: " ra
            local area=$(echo "scale=2; $pi * $ra * $ra" | bc)
            echo "The area of the circle is ${area}"
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] [INFO] :: Calculated area of the circle with radius $ra: $area" >> calculate_area.log
            ;;
        2)
            read -p "Enter the side: " si
            area=$((${si}*${si}))
            echo "The area of square is ${area}"
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] [INFO] :: Calculated area of the square with side $si: $area" >> calculate_area.log
            ;;
        3)
            read -p "Enter the length: " l
            read -p "Enter the width: " w
            area=$((${l}*${w}))
            echo "The area of the rectangle is ${area}"
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] [INFO] :: Calculated area of the rectangle with length $l and width $w: $area" >> calculate_area.log
            ;;
        ?)
            show_help
            ;;
    esac
}

# Functions to calculate area for specific shapes
circle() {
    local radius=$1
    area_of_circle=$(echo "scale=2; 3.14156 * $radius * $radius" | bc)
    echo "The area of circle: ${area_of_circle}"
}

square() {
    local side=$1
    area_of_square=$((${side}*${side}))
    echo "The area of square: ${area_of_square}"
}

rectangle() {
    local l=$1
    local w=$2
    area_of_rectangle=$((${l}*${w}))
    echo "The area of rectangle: ${area_of_rectangle}"
}

# Display help message if no arguments are provided
if [[ $# -eq 0 ]]; then
    show_help
fi

# Command-line argument handling
case $1 in
    --debug)
        # Debug mode: Prints calculation details
        if [[ $2 == "circle" ]] && [[ $# -eq 3 ]]; then
            circle "$3"
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] [INFO] :: Calculated area of the circle with radius $3: $area_of_circle"
        elif [[ $2 == "square" ]] && [[ $# -eq 3 ]]; then
            square "$3"
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] [INFO] :: Calculated area of the square with side $3: $area_of_square"
        elif [[ $2 == "rectangle" ]] && [[ $# -eq 4 ]]; then
            rectangle "$3" "$4"
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] [INFO] :: Calculated area of the rectangle with length $3 and width $4: $area_of_rectangle"
        else
            show_help
        fi
        exit 0
        ;;
    --logfile)
        # Log mode: Saves calculation details to a log file
        if [[ $2 == "circle" ]] && [[ $# -eq 3 ]]; then
            circle "$3"
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] [INFO] :: Calculated area of the circle with radius $3: $area_of_circle" | tee -a calculate_area.log
        elif [[ $2 == "square" ]] && [[ $# -eq 3 ]]; then
            square "$3"
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] [INFO] :: Calculated area of the square with side $3: $area_of_square" | tee -a calculate_area.log
        elif [[ $2 == "rectangle" ]] && [[ $# -eq 4 ]]; then
            rectangle "$3" "$4"
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] [INFO] :: Calculated area of the rectangle with length $3 and width $4: $area_of_rectangle" | tee -a calculate_area.log
        else
            show_help
        fi
        exit 0
        ;;
    ?)
        show_help
        exit 1
        ;;
esac

# Parsing options for interactive mode and help
while getopts "hi" options; do
    case $options in
        h)
            show_help
            ;;
        i)
            cal 
            ;;
        ?)
            show_help
            exit 1
            ;;
    esac
done
