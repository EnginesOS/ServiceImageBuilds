#!/bin/sh

PID_FILE=/tmp/avahi-publisher.pid
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/kill_avahi.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_clear_restart_required
#if test -f /home/engines/run/flags/restart_required
# then
#  rm -f /home/engines/run/flags/restart_required
#fi

ip=`cat /home/net/ip`
echo "$ip mgmt.local" >/etc/avahi/hosts
ext_interface=`netstat -nr |grep ^0.0.0.0 | awk '{print $8}' |head -1`
#`cat /home/net/gateway_interface`
interfaces="${ext_interface} , docker0"
echo binding to $interfaces
cat /home/engines/templates/avahi/avahi-daemon.conf.tmpl | sed "/INTERFACES/s//$interfaces/" > /tmp/avahi-daemon.conf
cp /tmp/avahi-daemon.conf /etc/avahi/avahi-daemon.conf


sudo -n dbus-daemon --system --fork --nopidfile
dbus_pid=$!
echo $dbus_pid >/tmp/dbus.pid

sudo -n /usr/sbin/avahi-daemon --no-chroot  & 
echo $! >/tmp/avahi-daemon.pid

touch /home/avahi/hosts/engines.local
touch /home/avahi/hosts/avahi.local

ls /home/avahi/hosts/ > /home/avahi/hosts_list
/home/engines/scripts/engine/publish_aliases.sh  2>/dev/null &


touch /home/engines/run/flags/startup_complete

wait
exit_code=$?

kill -TERM   'cat PID_FILE'

sudo -n /home/engines/scripts/engine/_kill_avahi.sh 
sudo -n /home/engines/scripts/engine/_kill_dbus.sh $dbus_pid

rm /home/engines/run/flags/startup_complete
exit $exit_code