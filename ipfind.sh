#!/bin/bash

for var in {1..10}
do
   ping -c 1 mta$var.salespush.net 2>&1;
done