#!/bin/bash
echo "Stopping Hologram Networking"
sudo /usr/local/bin/hologram modem disconnect
sudo route add -net 0.0.0.0 gw 10.0.1.1 dev eth0
ping -c 3 8.8.8.8 > /dev/null && echo "Network Up" || echo "Network Down"
