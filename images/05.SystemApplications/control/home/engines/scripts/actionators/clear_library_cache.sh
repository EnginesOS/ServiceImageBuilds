#!/bin/sh
if test -f /home/app/data/v0/library.json
 then
	rm /home/app/data/v0/library.json
	echo Library cache cleared
 else
    echo Library cache was empty
fi    