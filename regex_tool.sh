#!/bin/bash

show_help() {
	echo "Usage: ./regex_tool.sh [-h] [-i] [--file filename] [operation regex [replacement]]"
	echo
	echo "Perform regex-based operations on text files."
	echo
	echo "Options:"
	echo "-h Display this help message."
	echo "-i Interactive mode."
	echo "--file filename Specify the file to operate on."
	echo
	echo "Operations:"
	echo "search regex Search for patterns using regex and display all matching lines."
	echo "replace regex new Replace occurrences of regex with new string."
}

if [[ $# -eq 0  ]]; then 
	show_help
fi

logfile=/home/user/sample_date/sample_text.txt
operation=search

search() {
	
	grep -i "$1" ${logfile}

}

replace() {
	
	local find=$1
	local replace=$2

	sed  s/${find}/${replace}/g $logfile

}

inter() {
	
	read -p "Enter the filename: " logfile
	read -p "Choose operation (search, replace): " operation
	read -p "Enter regex: " regex
	if [[ $operation == "replace" ]]; then
		read -p "Enter replacement text: " replacement
	fi

}

case $1 in 
	--file)
		logfile=$2
		operation=$3
		if [[ $3 == "search" ]]; then
			search "$4"
		fi
		exit 0
		;;
	?)
		show_help
		;;
esac

while getopts "hi" options; do
	case $options in
		h)
			show_help
			;;
		i)
			inter
			if [[ $operation == "search" ]]; then
				search "$regex"
			elif [[ $operation == "replace" ]]; then
				replace $regex $replacement
			else
				show_help
			fi
			exit 0
			;;
		?)
			show_help
			;;
	esac
done

