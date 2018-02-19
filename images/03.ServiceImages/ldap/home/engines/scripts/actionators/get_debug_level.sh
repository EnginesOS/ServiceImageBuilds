#!/bin/sh

if test -f /home/engines/run/flags/debug_level
 then
	debug_level=`cat /home/engines/run/flags/debug_level`
 else
  debug_level=0
fi

echo '{"debug_level":"'$debug_level'"}'