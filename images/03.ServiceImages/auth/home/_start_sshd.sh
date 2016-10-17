#!/bin/sh

/usr/sbin/sshd  -f /home/auth/ssh/sshd.conf -D -E /home/auth/logs/ssh.log &
