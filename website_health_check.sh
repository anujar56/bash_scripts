#!/bin/bash
logfile=/home/user/logfile.log
w_health=/home/user/error_reports/website_health.log
w_error=/home/user/error_reports/website_report.log

report() {
	
	echo "Error Report - $(date)" >> $w_error
	echo "Total Errors: $(cat $w_health | wc -l)" >> $w_error
	echo "Latest Error: $(tail -n1 $w_health )" >> $w_error


}
error() {
	
	tail -f $logfile  |while read -r line; do
		echo $line | grep -i error >> $w_health
		report
	done	
}


while true; do
	error
done
