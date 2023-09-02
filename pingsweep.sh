#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <network>"
    echo "Example: $0 192.168.1.0/24"
    exit 1
fi

network="$1"

echo "Scanning network: $network"

for host in $(seq 1 254); do
    ip="${network%.*}.$host"
    ping -c 1 -w 1 "$ip" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Host $ip is up"
    fi
done
