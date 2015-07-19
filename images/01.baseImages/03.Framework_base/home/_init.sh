#!/bin/sh

if ! test -f /engines/var/run/flags/built
 then
 	touch /engines/var/run/flags/built
fi
 
if ! test -f /engines/var/run/flags/ca-update
 	then
		sudo /home/engines/scripts/_update_ca.sh		
fi



