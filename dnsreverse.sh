#!/bin/bash

for ip in $(seq xxx xxx); #choose a range
do
host -t ptr 0.0.0.$ip | grep -v "0.0.0" | cut -d " " -f 5; #change 0.0.0. for your ip addr
done
