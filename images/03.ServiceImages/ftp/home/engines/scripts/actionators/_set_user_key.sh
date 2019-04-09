#!/bin/sh

ssh-keygen -e -f $2 > /etc/sftp/authorized_keys/$1
rm $2