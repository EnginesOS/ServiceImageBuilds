#!/bin/bash
sudo -n /home/_kill_kerberos.sh
kill -$SIGNAL `cat $PID_FILE`