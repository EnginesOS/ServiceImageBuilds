#!/bin/bash
cd /
tar -xpf -  2>/tmp/tar.errs

. /home/auth/.dbenv

cat /tmp/email/backup.*gz | gzip -d | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname
r=$?
rm  /tmp/auth/backup.*gz
exit $r
