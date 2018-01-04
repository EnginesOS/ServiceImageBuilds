#!/bin/sh
if test -f /home/app/control/data/v0/library.json
 then
	rm /home/app/control/data/v0/library.json
	echo Library cache cleared
 else
    echo Library cache was empty
fi    