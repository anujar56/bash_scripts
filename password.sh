#!/bin/bash

#pass function to check password is alphanumeric or not and has length greater then 8
pass() {

        local password=$1
        local min_l=8

        if [ ${#password} -gt $min_l ] && [[ $password =~ [a-z] ]] && [[ $password =~ [A-Z] ]] && [[ $password =~ [0-9] ]]
        then
		echo ""
                echo "Password is of correct length and is alphanumeric"
                return 0
        else
                echo "Try another password"
                return 1
        fi


}

#help function
show_help() {

	echo "Usage: $0 [options]"
	echo " "
	echo "Options"
	echo "-e : Enter the password"
	echo "-h : help"
	exit 0


}

#flags
while getopts "eh" options; do
	case $options in
		e)
			read -p "Enter the password: " psd
			pass "${psd}"
			;;

		h)
			show_help
			;;

		?) 
			echo "Invalid Options us: $0 -h"
			exit 1
			;;
	esac
done



