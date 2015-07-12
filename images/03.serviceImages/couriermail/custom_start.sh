#!/bin/bash
rm -f /run/apache2/apache2.pid 
/etc/init.d/rsyslog start
/usr/lib/courier/courierctl.start
/usr/sbin/esmtpd start
/usr/sbin/imapd-ssl start
/usr/sbin/imapd start
/usr/sbin/pop3d start
/usr/sbin/pop3d-ssl start
cp /usr/lib/courier/etc/webadmin/password  /etc/courier/webadmin/
 touch  /usr/lib/courier/etc/webadmin/unsecureok /etc/courier/webadmin/unsecureok
cp /usr/lib/courier/courier/webmail/webadmin /usr/lib/cgi-bin/
ln -s  /etc/apache2/mods-available/ssl.{conf,load}   /etc/apache2/mods-enabled/
ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/

/usr/sbin/apache2ctl -D FOREGROUND 
rm -f /run/apache2/apache2.pid 