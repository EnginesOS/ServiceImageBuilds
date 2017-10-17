#!/bin/sh

PID_FILE=/tmp/avahi-publisher.pid
export PID_FILE
. /home/engines/functions/trap.sh


if test -f /engines/var/run/flags/restart_required
 then
  rm -f /engines/var/run/flags/restart_required
fi

ip=`cat /home/net/ip`
echo "$ip mgmt.local" >/etc/avahi/hosts
ext_interface=`netstat -nr |grep ^0.0.0.0 | awk '{print $8}' |head -1`
#`cat /home/net/gateway_interface`
interfaces="${ext_interface} , docker0"

cat /home/engines/templates/avahiavahi-daemon.conf.tmpl | sed "/INTERFACES/s//$interfaces/" > /tmp/avahi-daemon.conf
cp /tmp/avahi-daemon.conf /etc/avahi/avahi-daemon.conf

sudo -n /home/engines/scripts/_start_syslog.sh

sudo -n dbus-daemon --system --fork --nopidfile
dbus_pid=$!
echo $dbus_pid >/tmp/dbus.pid

sudo -n /usr/sbin/avahi-daemon --no-chroot  & 
echo $! >/tmp/avahi-daemon.pid

touch /home/avahi/hosts/engines.local
touch /home/avahi/hosts/avahi.local

ls /home/avahi/hosts/ > /home/avahi/hosts_list
/home/engines/scripts/avahi/publish_aliases.sh &

#echo $! > 

touch /engines/var/run/flags/startup_complete

wait
exit_code=$?

kill -TERM   'cat PID_FILE'

sudo -n /home/engines/scripts/avahi/_kill_avahi.sh 
sudo -n /home/engines/scripts/avahi/_kill_dbus.sh $dbus_pid
sudo -n /home/engines/scripts/_kill_syslog.sh

rm /engines/var/run/flags/startup_complete
exit $exit_code