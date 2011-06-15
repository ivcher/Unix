#!/bin/bash
new_md5=1					
base_file="./base"				# base file name
test_file="./test"				# test file name
declare -a keys
declare -i i=0

function get_key 
{   key=$1
    for (( i=0; i <  ${#keys[*]}; i++ )) {
	if [ "${keys[$i]}" = "$key" ]; then
	    return $i
	fi
    }
    keys[$i]=$key
    return $i
}
function find_key
{	key=$1
	for (( i=0; i <  ${#keys[*]}; i++ )) 
	{	if [ "${keys[$i]}" = "$key" ]; then
	    return $i
		fi
	}
	return '-1';
}

while read tmp1 tmp2	
do
	if [ $new_md5 -eq 1 ]
	then
		new_md5=0
		md5_size="${tmp1}_${tmp2}"
	else
		if [ -n "${tmp1}" ]
		then
			get_key "${md5_size}_${tmp1}"
		else 
			new_md5=1
		fi
	fi
done < <(cat $test_file)	# if "$test_file|while read tmp1 tmp2" then array keys ne budet dopolnyatsyz kluchami is cicla while

cat $base_file|while read md5 size name
do
	key="${md5}_${size}_${name}"
	#echo $key : $md5,$size,$name
	find_key $key; i=$?
#	echo 1: $key i: $i
#	get_key $key; i=$?
#	echo 2: $key i: $i

	if [ $i -eq 255 ]
	then
		echo  Name: $name Md5: $md5 Size: $size
	fi
done	
