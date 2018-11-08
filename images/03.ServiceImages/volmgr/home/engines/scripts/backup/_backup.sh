#!/bin/sh
 tar -cpf - /var/fs/local/  2>  /tmp/tar.errors.txt  |gzip -c
 if test $? -ne 0
 then
 cat /tmp/tar.errors.txt >&2
exit -1
 fi
exit 0
 