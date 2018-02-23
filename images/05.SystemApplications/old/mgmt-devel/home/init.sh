#!/bin/bash



mkdir -p /home/engines/run/ /var/run/apache2/ /var/log/apache2/
chown  -R   $ContUser /home/engines/run/
chown  -R   $ContUser /home/app/
chown  -R   $ContUser /var/run/apache2/
chown  -R   $ContUser /var/log/apache2/



