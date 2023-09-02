#!/bin/bash

wget $1
grep href index.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" | grep -v "link" > "list"
for url in $(cat list);do host $url;done | grep "address"
