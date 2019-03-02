#/bin/sh
. /home/engines/scripts/engines/certs_dirs.sh
chown certs  `find  $StoreRoot -type d `
