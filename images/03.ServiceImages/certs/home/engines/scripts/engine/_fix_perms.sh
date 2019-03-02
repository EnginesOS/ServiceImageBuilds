#/bin/sh
. /home/engines/scripts/engine/certs_dirs.sh
chown certs  `find  $StoreRoot -type d `
