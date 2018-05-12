#!/bin/bash
d=$(date '+%Y-%m-%d-%s')
log=/var/log/NOVA/NOVA.log
dlog=/var/log/NOVA/NOVA-$d.log
MaxFileSize=2048
while true
do
	sh /home/pi/scripts/startup.sh >> $log
	#Get Size in Bytes
	file_size=`du -b $log | tr -s '\t' ' ' | cut -d' ' -f1`
	if [ $file_size -gt $MaxFileSize ];
	then
		mv $log /var/log/NOVA/NOVA-$d-{1,2,3}.log
		touch $log
	fi
done
