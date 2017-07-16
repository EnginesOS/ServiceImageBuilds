#!/bin/bash


cd /
tar -xzpf - 2>/tmp/tar.errs
tar -xzpf /tmp/syslog/backup.*gz 

r=$?

rm /tmp/syslog/backup.*gz

exit $? 
