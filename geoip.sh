#!/usr/bin/env bash

cat /home/morpheus/iplist.txt | awk '{print $Z}' > ipformat.txt
ipformat.txt|uniq > mainiplist.txt
IP=`cat mainiplist.txt`
for i in $IP
do
  echo "$i,`geoiplookup $i >> info.txt
done