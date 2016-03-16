#!/bin/sh



PID_FILE=/tmp/avahi-publisher.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

if test -f /engines/var/run/flags/restart_required
 then
  rm -f /engines/var/run/flags/restart_required
fi

ip=`cat /home/net/ip`
echo "$ip mgmt.local" >/etc/avahi/hosts
interfaces=`cat /home/net/gateway_interface`
interfaces=$interfaces , docker0

cat /home/templates/avahi-daemon.conf.tmpl | sed "/INTERFACES/s//$interfaces/" > /tmp/avahi-daemon.conf
cp /tmp/avahi-daemon.conf /etc/avahi/avahi-daemon.conf

sudo -n syslogd  -R syslog.engines.internal:514

sudo -n dbus-daemon --system --fork --nopidfile
dbus_pid=$!
echo $dbus_pid >/tmp/dbus.pid

sudo -n /usr/sbin/avahi-daemon --no-chroot  & 
echo $! >/tmp/avahi-daemon.pid

touch /home/avahi/hosts/engines.local
#/home/publish_aliases.sh
touch /home/avahi/hosts/avahi.local
ls /home/avahi/hosts/ > /home/avahi/hosts_list
/home/publish_aliases.sh &


touch /engines/var/run/flags/startup_complete

wait 

kill -TERM   'cat PID_FILE'

sudo /home/kill_avahi.sh 
sudo /home/kill_dbus.sh $dbus_pid
sudo /home/engines/scripts/_kill_syslog.sh

rm /engines/var/run/flags/startup_complete
