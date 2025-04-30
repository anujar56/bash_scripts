#!/bin/bash

dest=/home/abendale/downloads/downloadarchive
logdest=/home/abendale/downloads/downloadarchive/script.log


help() {
	echo "$0 [options] .."
	echo
	echo "-f pass a file to move to downloadarchive"
	echo "-h help"	

}




txt() {
	local c=$(find . -name '*.txt' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.txt ${dest}
		echo "${c} .txt file moved to downloadarchive--$(date)" >> ${logdest}
	fi
}


pdf() {
	
	local c=$(find . -name '*.pdf' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.pdf ${dest}
		echo "${c} .pdf file moved to downloadarchive--$(date)" >> ${logdest}
	fi
}


log() {
	
	local c=$(find . -name '*.log' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.log ${dest}
		echo "${c} .log file moved to downloadarchive--$(date)" >> ${logdest}
	fi
}


jpg() {
	local c=$(find . -name '*.jpg' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.jpg ${dest}
		echo "${c} .jpg file moved to downloadarchive--$(date)" >> ${logdest}
	fi
	}


png(){	
	local c=$(find . -name '*.png' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.png ${dest}
		echo "${c} .png file moved to downloadarchive--$(date)" >> ${logdest}
	fi
}

out(){

	local c=$(find . -name '*.out' | wc -l)
	if [[ $c -gt 0 ]]; then
		mv *.out ${dest}
		echo "${c} .out file moved to downloadarchive--$(date)" >> ${logdest}
        fi
}

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


if [[ $# -eq 0 ]]; then
	run
else
	case $1 in
		-f)
			shift # This removes the '-f' from $@
			for arg in "$@"; do
				mv ${arg} ${dest}
			done
			num=$(( $# - 1 ))
			echo "${num} file moved to downloadarchive--$(date)" | tee -a  ${logdest}
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





