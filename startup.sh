#!/bin/bash
d=$(date '+%Y-%m-%d-%s')
dlong=$(date)
i="0"

echo "$dlong Starting NOVA script."
sleep 10

if pgrep "ppp" > /dev/null
then
	echo "$dlong PPP Process Running."
	status="Running"
else
	echo "$dlong PPP Process Stopped."
	status="Not Running"
	sleep 10
	sudo /usr/local/bin/hologram modem connect
fi
sleep 10
sudo hologram send "Startup on $dlong, Hologram was $status."

while [ $i -lt 1 ]; do
if ip route | grep ppp > /dev/null
then
	echo "$dlong Route is UP!"
	sleep 60
else
	echo "$dlong Route is DOWN!"
	sudo /usr/local/bin/hologram modem disconnect
	sleep 10
	sudo /usr/local/bin/hologram modem connect
fi
done
