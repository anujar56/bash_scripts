#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

echo "Showing Size of each dir"
echo
du -sh ${!#}/* | sort -rh
echo
echo "====================="


precheck() {
        #precheck if $1 is file or dir. If file, exit. If dir, continue.
               
        du -sh $1/* &> /dev/null
        catch=$(echo $?)
        if [[ $catch -eq "1" ]]; then
                echo "$1 is a file. Skipping."
                exit 0
        fi
}


d=$(du -sh ${!#}/* | sort -rh | head -5 | awk '{print $2}' | xargs)

size() {
        
        precheck $1
        echo "======================"
        echo  -e "${GREEN}PATH : ${1}${RESET}" 
        echo "======================"
        du -sh $1/* | sort -rh 2> /dev/null
        
        files=$(du -sh $1/* | sort -rh | head -5 | awk '{print $2}' | xargs)
        
        for i in $files; do
                du -sh $i/* &> /dev/null
                catch=$(echo $?)
                if [[ $catch -eq "1" ]]; then
                        continue
                fi

                #if [[ $(du -sh $i/* | wc -l) -gt "4" ]]; then
                #       continue
                #fi            
                size $i
        done

}

exclude=()

while getopts "e:" opt; do
        case $opt in
                e) 
                        ex=$(($# - 3))
                        exclude+=("$OPTARG")
                        # collect additional values
                        for ((i=0; i<$ex; i++));
                                do
                                        exclude+=("${!OPTIND}")
                                        ((OPTIND++))
                                done
                        ;;
        esac
done


for k in $d; do
        #exclude the directories here
        
        for j in ${exclude[@]}; do
                if [[ $k == $j ]]; then
                        continue 2
                fi
        done

        du -sh $k/* &> /dev/null
        catch1=$(echo $?)
        if [[ $catch1 -eq "1" ]]; then
                 echo -e "${RED}$k is a file. Skipping.${RESET}"
                 continue
        fi

        size $k
done
