#!/bin/sh

mkdir -p /engines/var/run/flags/
 

touch  /engines/var/run/flags/startup_complete
while test 0 -ne 1
do
sleep 600
done

rm /engines/var/run/flags/startup_complete