#!/bin/bash


cd /
tar -xpf - 2>/tmp/tar.errs
tar -xpf /tmp/syslog/backup.*

r=$?

rm /tmp/syslog/backup.*

exit $? 
