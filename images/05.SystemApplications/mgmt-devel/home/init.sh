#!/bin/bash



mkdir -p /engines/var/run/ /var/run/apache2/ /var/log/apache2/
chown  -R   $ContUser /engines/var/run/
chown  -R   $ContUser /home/app/
chown  -R   $ContUser /var/run/apache2/
chown  -R   $ContUser /var/log/apache2/



