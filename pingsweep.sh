#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo -e "\e[1;32m Usage: $0 <network>"
    echo -e "\e[1;36m Example: $0 192.168.1.0/24"
    exit 1
fi

network="$1"

echo -e "\e[1;32m Scanning network: \e[0;37m\e[1;37m$network\e[0;37m"

for host in $(seq 1 254); do
    ip="${network%.*}.$host"
    ping -c 1 -w 1 "$ip" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "Host \e[1;37m$ip\e[0;37m is \e[1;31m up\e[0;37m"
    fi
done
