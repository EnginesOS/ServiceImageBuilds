#!/bin/sh

if test -f /home/configurators/saved/smarthost
then
	cat /home/configurators/saved/smarthost
else
	echo "Not Set"
fi