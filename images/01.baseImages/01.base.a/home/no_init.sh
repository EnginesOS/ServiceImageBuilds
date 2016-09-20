#!/bin/bash
rm -f /usr/sbin/initctl /usr/sbin/invoke-rc.d /usr/sbin/restart /usr/sbin/start /usr/sbin/stop /usr/sbin/start-stop-daemon /usr/sbin/service

ln -s /bin/true /usr/sbin/initctl
ln -s /bin/true /usr/sbin/invoke-rc.d
ln -s /bin/true /usr/sbin/restart
ln -s /bin/true /usr/sbin/stop
ln -s /bin/true /usr/sbin/start
ln -s /bin/true /usr/sbin/start-stop-daemon
ln -s /bin/true /usr/sbin/service
