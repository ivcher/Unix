#!/bin/sh
new_md5=1					
base_file=base				# base file name
test_file=test				# test file name
cat "./test"|while read tmp	
do
	if [ $new_md5 -eq 1 ]
	then
		new_md5=0
		md5_size=$tmp
	else
		if [ -n "$tmp" ] 
		then	
			if ! grep -q "$md5_size $tmp" $base_file 
			then
				echo "$md5_size $tmp"	#"$md5_size $tmp"
			fi
		else
			new_md5=1
		fi
	fi
done