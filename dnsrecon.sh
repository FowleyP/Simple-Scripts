#!/bin/bash

for x in $(cat /path/to/wordlist.txt);
do
host $x.$1 | grep -v "NXDOMAIN";
done
