#!/bin/bash


show_help() {

	echo "Usage: $0 [option] [shape] [dimension1] [dimension2]"
	echo ""
	echo ""
	echo "Calculate the area of various geometric shapes."
	echo ""
	echo ""
	echo "Options:"
	echo "  -h              Display this help message."
	echo "  -i              Interactive mode."
	echo ""
	echo "Shapes and dimensions:"
	echo "  circle radius          Calculate the area of a circle."
	echo "  square side            Calculate the area of a square."
	echo "  rectangle length width Calculate the area of a rectangle."
	exit 0

}


circle() {

	local radius=$1
	local pi=3.14
	local area=$(awk "BEGIN {print ${pi}*${radius}*${radius}}")
	echo "Area of Circle is : $area"
	return 0
	
}

sqa() {
	local side=$1
	local area=$((${side}*${side}))
	echo "Area od Square is: ${area}"
	return 0

}

rec() {
	local l=$1
	local h=$2
	local area=$((${l}*${h}))
	echo "Area of Rectangle : ${area}"
	return 0
}

inter() {
	echo "Choose the shape to calculate the area:"
	echo "1. Circle"
	echo "2. Square"
	echo "3. Rectangle"
	echo "Enter your choice (1/2/3):"

	echo "Enter choice: "
	read choice
	echo ""

	if [[ ${choice} -eq 1  ]]; then

		echo "Enter the radius of the circle:"
		echo "Enter radius: "
		read radius
		circle ${radius}

	elif [[ ${choice} -eq 2 ]]; then
		echo "Enter the side of the square: "
		echo "Enter side"
		read side
		sqa ${side}
	else
		inter
	fi

	
}

while getopts "ir:c:s:h" options; do
	case $options in 
		h) 
			show_help
			;;
		c)
			circle "${OPTARG}"
			exit 0
			;;
		s)
			sqa "${OPTARG}"
			;;
		r)	
			IFS="," read -r l h <<< ${OPTARG}
			rec $l $h
			;;
		i)
			inter
			;;
		?)
			echo "Invalid option: "
			echo "Use $0 -h"
			exit 1
			;;
	esac
done

