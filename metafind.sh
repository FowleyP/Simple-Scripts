#!/bin/bash

if [ "$1" = "" ]
then
        echo -e "\e[1;32m --------------------------------------------"
        echo -e "\e[1;36m Usage: ./metafind.sh target + ext"
        echo -e "\e[1;32m --------------------------------------------"
else
        echo -e "\e[1;35m SCANNING..."
        sleep 2

        target=$1
        ext=$2

        echo -e "\e[1;33m"

for argument in "$1","$2" ;do lynx --dump "https://google.com/search?&q=site:"$1"+ext:"$2 | grep $2 | cut -d "=" -f 2 | egrep -v "site|google" | sed 's/...$//';

done
fi
