#!/bin/bash
sudo -n /home/engines/scripts/signal/_kill_kerberos.sh
kill -$SIGNAL `cat $PID_FILE`