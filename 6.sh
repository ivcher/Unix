#!/bin/sh
new_md5=1					
base_file=base				# base file name
test_file=test				# test file name
cat "./test"|while read tmp	
do
	echo -e "new_md5=$new_md5 \ntmp=$tmp "
	if [ $new_md5 -eq 1 ]
	then
		new_md5=0
		md5_size=$tmp
	else
		if [ -n "$tmp" ] 
		then	
			echo "$md5_size $tmp"
			if grep "$md5_size $tmp" $base_file 
			then
				echo "exist"  # "$md5_size $tmp"
			else
				echo "not exist"
			fi
		else
			echo "noll"
			new_md5=1
		fi
	echo "	"
	fi
done