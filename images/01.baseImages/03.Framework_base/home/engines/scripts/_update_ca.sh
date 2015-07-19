#!/bin/sh

if test -f /usr/local/share/ca-certificates/engines_internal_ca.crt
	then
		sudo update-ca-certificates
	fi