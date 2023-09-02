#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo -e "\e[1;36mUsage: $0 <ip_range> <target_port> <packet_type>"
    echo -e "Example: $0 192.168.1.0/24 80 tcp"
    echo -e "Packet types: tcp, udp\e[0;37m"
    exit 1
fi

ip_range="$1"
target_port="$2"
packet_type="$3"

echo -e "\e[1;37mScanning port \e[1;32m$target_port \e[1;37mon IP range \e[1;32m$ip_range \e[1;37musing hping3...\e[0;37m"

for ip in $(seq 1 254); do
    current_ip=$(echo "$ip_range" | sed "s/0\/24/$ip/")
    if [ "$packet_type" == "tcp" ]; then
        hping3 -S -p "$target_port" -c 1 "$current_ip" 2>/dev/null | grep -q "flags=SA"
    elif [ "$packet_type" == "udp" ]; then
        hping3 --udp -p "$target_port" -c 1 "$current_ip" 2>/dev/null | grep -q "len="
    else
        echo -e "\e[1;31mInvalid packet type. Supported types: tcp, udp\e[0;37m"
        exit 1
    fi

    if [ $? -eq 0 ]; then
        echo -e "\e[1;37mPort \e[1;32m$target_port \e[1;37mis \e[1;36mopen\e[1;37m on \e[1;32m$current_ip.\e[0;37m"
    fi
done
