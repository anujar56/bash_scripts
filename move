#!/bin/bash

# Define destination directories and log file
dest=/home/anuj/downloads/downloadarchive
logdest=/home/anuj/downloads/downloadarchive/script.log
loc=/home/anuj/downloads

# Help function to display usage information
help() {
	echo "$0 [options] .."
	echo
	echo "-d pass dir to move to downloadarchive"
	echo "-f pass a file to move to downloadarchive"
	echo "-h help"	
}

# Function to move all .txt files to archive
txt() {
	local c=$(find ${loc} -name '*.txt' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.txt ${dest} 2> /dev/null
		echo "${c} .txt file moved to downloadarchive--$(date)" >> ${logdest}
	fi
}

# Function to move all .pdf files to archive
pdf() {
	
	local c=$(find ${loc} -name '*.pdf' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.pdf ${dest} 2> /dev/null
		echo "${c} .pdf file moved to downloadarchive--$(date)" >> ${logdest}
	fi
}

# Function to move all .log files to archive
log() {
	
	local c=$(find ${loc} -name '*.log' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.log ${dest} 2> /dev/null
		echo "${c} .log file moved to downloadarchive--$(date)" >> ${logdest}
	fi
}

# Function to move all .jpg files to archive
jpg() {
	local c=$(find ${loc} -name '*.jpg' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.jpg ${dest} 2> /dev/null
		echo "${c} .jpg file moved to downloadarchive--$(date)" >> ${logdest}
	fi
	}

# Function to move all .png files to archive
png(){	
	local c=$(find ${loc} -name '*.png' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.png ${dest} 2> /dev/null
		echo "${c} .png file moved to downloadarchive--$(date)" >> ${logdest}
	fi
}

# Function to move all .out files to archive
out(){
	local c=$(find ${loc} -name '*.out' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.out ${dest} 2> /dev/null
		echo "${c} .out file moved to downloadarchive--$(date)" >> ${logdest}
        fi
}

# Main function that runs all individual file type functions
# Only executes if there are more than 12 files in the directory
run() {
	if [[ $(ls | wc -l) -gt 12 ]]; then
		txt
		pdf
		out
		png
		jpg
		log
	else
		echo "Files count is less than 12 -- $(date)" | tee -a ${logdest}
	fi
}

# Main execution logic
if [[ $# -eq 0 ]]; then
	# If no arguments provided, run the automated cleanup
	run
else
	# Process command line arguments
	case $1 in
		-f)
			shift # This removes the '-f' from $@
			for arg in "$@"; do
				mv ${arg} ${dest}
			done
			#num=$(( $# - 1 ))
			echo "$# file moved to downloadarchive--$(date)" | tee -a  ${logdest}
			;;
		-d)
			shift # This removes the '-d' from $@
			for arg in "$@"; do
				mv ${arg} ${dest}/${arg}
			done
			#num=$(( $# - 1 ))
			echo "$# dir moved to downloadarchive--$(date)" | tee -a  ${logdest}
			;;
		-h)
			help
			;;
		*)
			echo "Unknown option : $1"
			echo
			help
			;;
	esac
fi
