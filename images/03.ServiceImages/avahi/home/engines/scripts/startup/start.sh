#!/bin/sh

PID_FILE=/home/engines/run/avahi-publisher.pid
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/kill_avahi.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_clear_restart_required

ip=`cat /home/engines/system/net/ip`
echo "$ip mgmt.local" >/etc/avahi/hosts
ext_interface=`netstat -nr |grep ^0.0.0.0 | awk '{print $8}' |head -1`

interfaces="${ext_interface} , docker0"
echo binding to $interfaces
cat /home/engines/templates/avahi/avahi-daemon.conf.tmpl | sed "/INTERFACES/s//$interfaces/" > /tmp/avahi-daemon.conf
cp /tmp/avahi-daemon.conf /etc/avahi/avahi-daemon.conf


sudo -n dbus-daemon --system --fork --nopidfile
dbus_pid=$!
echo $dbus_pid >/home/engines/run/dbus.pid

sudo -n /usr/sbin/avahi-daemon --no-chroot  & 
echo $! >/home/engines/run/avahi-daemon.pid

touch /home/avahi/hosts/engines.local
touch /home/avahi/hosts/avahi.local

ls /home/avahi/hosts/ > /home/avahi/hosts_list

/home/engines/scripts/engine/publish_aliases.sh  2>/dev/null &

startup_complete

wait
exit_code=$?

shutdown_complete
