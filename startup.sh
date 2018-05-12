#!/bin/bash
d=$(date '+%Y-%m-%d-%S')
dlong=$(date)
i="0"

echo "Starting NOVA script."
if pgrep "ppp" > /dev/null
then
	echo "PPP Process Running."
	status="Running"
else
	echo "PPP Process Stopped."
	status="Not Running"
	sudo /usr/local/bin/hologram modem connect
fi
sudo hologram send "Startup on $dlong, Hologram was $status."
while [ $i -lt 1 ]; do
if ip route | grep ppp > /dev/null
then
	echo "Route is UP!"
	sleep 60
else
	echo "Route is DOWN!"
	sudo /usr/local/bin/hologram modem disconnect
	sudo /usr/local/bin/hologram modem connect
fi
done
