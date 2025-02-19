#!/bin/bash

echo  "Starting System Update and System Upgrade......"
read -p "Do you want to procced(y/n): " ans
if [[ $ans == "y" ]]; then
	which apt
	s=$?
	if [[ $s -eq 0 ]]; then
		apt update #2&> /dev/null
	fi
fi


