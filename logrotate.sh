#!/bin/bash
dlong=$(date '+%Y-%m-%d-%s')
log=/var/log/NOVA/NOVA.log
MaxFileSize=2048
while true
do
	sh /home/pi/scripts/startup.sh >> $log
	#Get Size in Bytes
	file_size=`du -b $log | tr -s '\t' ' ' | cut -d' ' -f1`
	if [ $file_size -gt $MaxFileSize ];
	then
		echo "$dlong Moving logs." >> $log
		dlog=/var/log/NOVA/NOVA-$dlong-{1,2,3}.log
		mv $log $dlog
		touch $log
		echo "$dlong Logs Moved to $dlog" >> $log
	fi
done
