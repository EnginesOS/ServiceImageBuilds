#!/bin/sh
echo access_id="$access_id">/home/engines/scripts/configurators/saved/credentials
echo access_key="$access_key"  >>/home/engines/scripts/configurators/saved/credentials

 . /home/engines/functions/checks.sh
exit 0
