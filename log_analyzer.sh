#!/bin/bash


logfile=~/bash/sample_log.log
operation=default
criteria=error

show_help() {
	echo "Usage: ./log_analyzer.sh [-h] [-i] [--file filename] [operation criteria]"
	echo
	echo "Perform regex-based log analysis on system log files."
	echo
	echo "Options:"
	echo "-h Display this help message."
	echo "-i Interactive mode."
	echo "--file filename Specify the log file to operate on."
	echo
	echo "Operations:"
	echo "filter level Filter logs by level (INFO, WARN, ERROR, DEBUG)."
	echo "categorize Categorize logs by level and display counts."

}


filter() {
	
	cat $logfile | grep -i $1

}

categorize() {
	cat $1 | awk '{print $3}' | sort | uniq -c | sort -r

}


interactive() {

		read -p "Enter the log filename:" logfile
		read -p "Choose operation (filter, categorize):" operation
		if [[ $operation == "filter" ]]; then
			read -p "Enter criteria (for filter: ERROR/INFO/WARN/DEBUG):" criteria
		fi


}

if [[ $# -eq 0 ]]; then
	show_help
fi

while getopts "hi" options; do
	case $options in
		h)
			show_help
			;;
		i)
			interactive
			echo
			if [[ $operation == "filter" ]];then
				filter "$criteria"
			else
				categorize "$logfile" 
			fi
			;;
		?)
			show_help
			;;

	esac
done
