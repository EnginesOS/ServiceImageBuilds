#!/bin/bash

if test -f /home/certs/store/public/certs/$1.crt
 then
 	rm /home/certs/store/public/certs/$1.crt
 else
 	echo "Not Such Cert $1.crt"
 	exit -1
fi
 	
if test -f /home/certs/store/public/keys/$1.key
 then
 	rm /home/certs/store/public/keys/$1.key
 else
 	echo "No Such key $1.key"
 	exit -1
fi

echo true
exit
 	
