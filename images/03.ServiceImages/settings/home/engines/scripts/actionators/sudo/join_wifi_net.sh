#!/bin/sh

cat /home/engines/templates/wpa_supplicant-wlan.conf | while read LINE
do
 eval echo "$LINE" >> /etc/wpa_supplicant-wlan.conf
done
