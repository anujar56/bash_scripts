#!/bin/bash
logfile=~/log_file.log

show_help() {

	echo "Usage: ./log_analyzer.sh [-h] [-i] [log_file_path]"
	echo 
	echo "Analyze system logs to identify and summarize error messages."
	echo
	echo "Options:"
	echo "-h Display this help message."
	echo "-i Interactive mode."
	echo "log_file_path Specify the path to the log file. Default is /var/log/syslog."
}

display() {
	
	echo "Select the type of log analysis to perform:"
	echo "1. Count Errors"
	echo "2. List Errors"
	echo "3. Search Errors"
	read -p "Enter your choice: " choice

	case $choice in
		1)
			local count=$(cat $logfile | grep -i error | wc -l)
			echo "Total number of errors: ${count}"
			exit 0
			;;
		2)
			echo "List of unique error messages and their frequencies:"
			cat $logfile | grep error | awk -F ":" '{print "error: " $NF}' | sort | uniq -c
			;;
		3)
			echo "Searching for errors containing the keyword 'error':"
			cat $logfile | grep -i error
			;;
		?)
			show_help
			exit 1
			;;

	esac

}

if [[ $# -eq 0 ]]; then
	show_help
	exit 1
fi

if [[ $# == 2 ]]; then
	logfile=$2
fi

while getopts "hi" options; do
	case $options in
		h)
			show_help
			exit 1
			;;
		i)
			display
			;;
		?)
			show_help
			exit 1
			;;
	esac
done
	
