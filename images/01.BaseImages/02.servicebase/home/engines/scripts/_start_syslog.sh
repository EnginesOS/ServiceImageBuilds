#!/bin/sh

#syslogd -n   -R syslog.engines.internal:514 &
rsyslogd -c4 -i /var/run/rsyslogd.pid 