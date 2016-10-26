#!/bin/sh

#syslogd -n   -R syslog.engines.internal:514 &
rsyslogd  -i /var/run/rsyslogd.pid 