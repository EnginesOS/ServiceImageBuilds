#!/bin/sh
if ! test -d /var/logs/sshd
 then
	mkdir -p /var/logs/sshd
	touch /var/logs/sshd/ssh.log
	chgrp -R 22020 /var/logs/sshd
	chmod g+rw -R /var/logs/sshd
fi
if ! test -d /var/run/sshd
then 
 mkdir -p /var/run/sshd
fi

/usr/sbin/sshd   -D -E /var/logs/sshd/ssh.log 

