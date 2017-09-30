#!/bin/sh
cd /
tar -xpf - 2>/tmp/tar.errs
tar -xpf /tmp/syslog/backup.*

r=$?

rm /tmp/syslog/backup.*

exit $? 


# cat - |tar -xpf - /var/fs/local/ 