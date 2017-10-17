#!/bin/bash
sudo -n /home/engines/scripts/auth/_kill_kerberos.sh
kill -$SIGNAL `cat $PID_FILE`