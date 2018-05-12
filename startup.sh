#!/bin/bash
d=$(date '+%Y-%m-%d')
dlong=$(date)
log=/var/log/NOVA/NOVA-$d.log
touch $log
echo "Starting NOVA script on $dlong" >> $log
sleep 10
if pgrep "ppp" > /dev/null
then
	echo "Running" >> $log
	status="Running"
else
	echo "Stopped" >> $log
	status="Not Running"
	sudo hologram modem connect >> $log
fi
sleep 10
sudo hologram send "Startup on $dlong, Hologram was $status." >> $log
