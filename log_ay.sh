#!/bin/bash

# Default log file path
logfile=~/log_file.log

# Function to display help message
show_help() {
    echo "Usage: ./log_analyzer.sh [-h] [-i] [log_file_path]"
    echo
    echo "Analyze system logs to identify and summarize error messages."
    echo
    echo "Options:"
    echo "-h               Display this help message."
    echo "-i               Interactive mode."
    echo "log_file_path    Specify the path to the log file. Default is ~/log_file.log."
}

# Function to display interactive log analysis options
display() {
    echo "Select the type of log analysis to perform:"
    echo "1. Count Errors"
    echo "2. List Errors"
    echo "3. Search Errors"
    
    # Prompt user for input
    read -p "Enter your choice: " choice

    case $choice in
        1)  # Count the number of errors in the log file
            local count=$(cat $logfile | grep -i error | wc -l)
            echo "Total number of errors: ${count}"
            exit 0
            ;;
        2)  # List unique error messages with their occurrence count
            echo "List of unique error messages and their frequencies:"
            cat $logfile | grep -i error | awk -F ":" '{print "error: " $NF}' | sort | uniq -c
            ;;
        3)  # Search for error messages in the log file
            echo "Searching for errors containing the keyword 'error':"
            cat $logfile | grep -i error
            ;;
        ?)  # Show help message for invalid choices
            show_help
            exit 1
            ;;
    esac
}

# If no arguments are provided, display help and exit
if [[ $# -eq 0 ]]; then
    show_help
    exit 1
fi

# Check if a custom log file is provided as an argument
if [[ $# == 2 ]]; then
    if [[ -e $2 ]]; then
        logfile=$2  # Set the user-specified log file path
    else
        echo "File $2 doesn't exist"
        exit 1
    fi
fi

# Process command-line options
while getopts "hi" options; do
    case $options in
        h)  # Show help message
            show_help
            exit 1
            ;;
        i)  # Enter interactive mode
            display
            ;;
        ?)  # Show help for invalid options
            show_help
            exit 1
            ;;
    esac
done
