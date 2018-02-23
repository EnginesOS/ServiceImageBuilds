#!/bin/sh

/etc/init.d/ssh start
/etc/init.d/apache2 start
 /usr/sbin/nagios3  /etc/nagios3/nagios.cfg




