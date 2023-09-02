#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo -e "\e[1;36m Usage: $0 <target_host> <port_range>"
    echo -e "Example: $0 example.com 80-100 \e[0;37m"
    exit 1
fi

target_host="$1"
port_range="$2"

echo -e "\e[1;36m Scanning ports: \e[0;37m\e[1;37m$target_host\e[0;37m..."

start_port=$(echo "$port_range" | cut -d'-' -f1)
end_port=$(echo "$port_range" | cut -d'-' -f2)

for port in $(seq "$start_port" "$end_port"); do
    (timeout 1 bash -c "echo >/dev/tcp/$target_host/$port") >/dev/null 2>&1 && \
        echo -e "Port \e[1;36m$port\e[0;37m is \e[1;32mopen\e[0;37m" || \
        echo -e "Port \e[1;36m$port\e[0;37m is \e[1;31mclosed\e[0;37m"
done
