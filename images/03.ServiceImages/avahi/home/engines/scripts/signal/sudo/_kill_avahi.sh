#!/bin/sh

#kill -TERM ` cat /home/engines/run/avahi-daemon.pid`
#!/bin/sh

PID_FILES="/home/engines/run/avahi-daemon.pid /tmp/dbus.pid"
. /home/engines/functions/signals.sh

default_signal_processor
exit 0