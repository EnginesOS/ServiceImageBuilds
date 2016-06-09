#!/bin/bash

if test -f /home/certs/store/public/ca/certs/$1.crt
 then
 	cat /home/certs/store/public/ca/certs/$1.crt
 else
 	echo "Not Such Cert"
 	exit -1
 	fi
 	exit
 	
