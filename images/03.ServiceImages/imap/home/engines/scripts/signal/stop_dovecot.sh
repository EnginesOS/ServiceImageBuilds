#!/bin/sh
echo _stop_dovecot.sh $SIGNAL $PID_FILE
sudo -n /home/engines/scripts/signal/_stop_dovecot.sh $SIGNAL $PID_FILE