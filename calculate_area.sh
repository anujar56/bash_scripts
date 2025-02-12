#!/bin/bash

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
		?)
			show_help
			;;
	esac
	

	
}


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

