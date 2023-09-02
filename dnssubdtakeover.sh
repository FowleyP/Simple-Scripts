#!/bin/bash

for x in $(cat /path/to/wordlist.txt);
do
host -t cname $x.$1 | grep "alias for";
done
