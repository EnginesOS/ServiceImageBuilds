#!/bin/sh

#kill -TERM ` cat /tmp/avahi-daemon.pid`
#!/bin/sh

PID_FILES="/tmp/avahi-daemon.pid /tmp/dbus.pid"
. /home/engines/functions/signals.sh

default_signal_processor
exit 0