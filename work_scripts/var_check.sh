#!/bin/bash

echo "Showing Size of each dir"
echo
du -sh /var/* | sort -rh
echo
echo "====================="



d=$(du -sh /var/* | sort -rh | head -5 | awk '{print $2}' | xargs)

size() {

        #du -sh $1/* &> /dev/null
        #catch=$(echo $?)
        #if [[ $catch -eq "1" ]]; then
        #       exit 0
        #fi
        echo
        echo $1 
        echo
        du -sh $1/* | sort -rh 2> /dev/null
        echo 
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


for k in $d; do
        if [[ $k == "/var/lib" ]]; then
                continue
        fi
        size $k
done
