#!/bin/sh
cd /
tar -xzpf - 2>/tmp/tar.errs
tar -xzpf /tmp/syslog/backup.*

r=$?

rm /tmp/syslog/backup.*

exit $? 


# cat - |tar -xpf - /var/fs/local/ 