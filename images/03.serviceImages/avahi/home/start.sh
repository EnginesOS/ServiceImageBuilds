#!/bin/sh



PID_FILE=/var/run/avahi-daemon/pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

ip=`cat /home/lan_ip`
echo "$ip mgmt.engines.local" >/etc/avahi/hosts

sudo -n syslogd  -R syslog.engines.internal:5140

sudo -n dbus-daemon --system --fork --nopidfile
dbus_pid=$!
echo $dbus_pid >/tmp/dbus.pid

sudo -n /usr/sbin/avahi-daemon --no-chroot  & 
#echo $! >$PID_FILE
touch /home/avahi/hosts/engines.local
/home/publish_aliases.sh
touch /engines/var/run/flags/startup_complete
wait  ` cat $PID_FILE`

sudo /home/kill_dbus.sh $dbus_pid
sudo /home/engines/scripts/_kill_syslog.sh

rm /engines/var/run/flags/startup_complete
