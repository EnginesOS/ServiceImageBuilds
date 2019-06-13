#/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
chown certs  `find  $StoreRoot -type d `
