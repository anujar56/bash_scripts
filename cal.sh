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

while getopts "r:c:s:h" options; do
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
		?)
			echo "Invalid option: "
			echo "Use $0 -h"
			exit 1
			;;
	esac
done

