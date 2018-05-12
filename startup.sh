#!/bin/bash
d=$(date '+%Y-%m-%d')
dlong=$(date)
log=/var/log/NOVA/NOVA-$d.log
i="0"

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
	sleep 10
	sudo /usr/local/bin/hologram modem connect >> $log
fi
sleep 10
sudo hologram send "Startup on $dlong, Hologram was $status." >> $log

while [ $i -lt 1 ]; do
if ip route | grep ppp > /dev/null
then
	sleep 60
else
	sudo /usr/local/bin/hologram modem disconnect >> $log
	sleep 10
	sudo /usr/local/bin/hologram modem connect >> $log
fi
done
