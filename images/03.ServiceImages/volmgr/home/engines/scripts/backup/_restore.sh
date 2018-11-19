#!/bin/sh
cd /
tar -xzpf - 
tar -xzpf /tmp/syslog/backup.*

r=$?

rm /tmp/syslog/backup.*

exit $? 


# cat - |tar -xpf - /var/fs/local/ 