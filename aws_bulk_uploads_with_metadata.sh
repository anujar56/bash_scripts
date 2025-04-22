#!/bin/bash
#aws s3api head-object --bucket spl --key one.out | jq .Metadata | jq to_entries[] | jq -r .key
#To take keys
#
#aws s3api head-object --bucket spl --key one.out | jq .Metadata | jq to_entries[] | jq -r .value
#To take out values

for o in $(aws s3api list-objects-v2 --bucket spl | jq -r .Contents[].Key);
do
	count=$(aws s3api head-object --bucket spl --key ${o} | jq .Metadata | jq to_entries[] | jq -r .key | wc -l)
	st=" "
	c=$(( $count-1 ))
	for ((i=1; i<${count}; i++)); do st+="%s,"; done
	declare -A dit
	for m in $(aws s3api head-object --bucket spl --key ${o} | jq .Metadata | jq to_entries[] | jq -r .key)
	do
		dit["${m}"]="$(aws s3api head-object --bucket spl --key ${o} | jq -r .Metadata.${m})"
	done


	echo "------------MetaData Variables for file ${o}---------------- "
	
	meta=$(for key in ${!dit[@]};
	do	
		echo "${key}=${dit[${key}]}"
	done | xargs -n ${count} printf "${st}%s")
	
	echo $meta
	aws s3api copy-object --bucket spl --copy-source spl/${o} --key ${o} --metadata-directive REPLACE --metadata ${meta},last_edit=script

	echo



done

	



