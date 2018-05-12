#!/bin/bash
dlong=$(date '+%Y-%m-%d-%S')
log=/var/log/NOVA/NOVA.log
MaxFileSize=2048
while true
do
	sh /home/pi/scripts/startup.sh | ts '[%Y-%m-%d %H:%M:%S]' >> $log
	#Get Size in Bytes
	file_size=`du -b $log | tr -s '\t' ' ' | cut -d' ' -f1`
	if [ $file_size -gt $MaxFileSize ];
	then
		echo "Moving logs." | ts '[%Y-%m-%d %H:%M:%S]' >> $log
		dlog=/var/log/NOVA/NOVA-$dlong.log
		mv $log $dlog
		touch $log
		chown -R pi:pi /var/log/NOVA
		echo "Logs Moved to $dlog" | ts '[%Y-%m-%d %H:%M:%S]' >> $log
	fi
done
