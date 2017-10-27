#!/bin/sh
echo _stop_dovecot.sh $SIGNAL $PIDFILE
sudo -n /home/engines/scripts/signal/_stop_dovecot.sh $SIGNAL $PIDFILE