#!/bin/bash

install_target=$1
cert_name=$2

function install_cert {
mkdir -p /home/certs/store/services/${service}/certs/
mkdir -p /home/certs/store/services/${service}/keys/
cp /home/certs/store/public/certs/${cert_name}.crt /home/certs/store/services/${service}/certs/engines.crt 
cp /home/certs/store/public/keys/${cert_name}.key /home/certs/store/services/${service}/keys/engines.key
chown $id /home/certs/store/services/${service}/keys/engines.key /home/certs/store/services/${service}/certs/engines.crt 
chmod og-rw /home/certs/store/services/${service}/keys/engines.key /home/certs/store/services/${service}/certs/engines.crt 
}

function install_smtp {
service=smtp
id=22003
install_cert
}

function install_ftp {
service=ftp
id=22010
install_cert
}

function install_imap {
service=imap
id=22013
install_cert
}

function install_ivpn {
service=ivpn
id=22031
install_cert
}

function install_email {
service=email
id=22005
install_cert
}

function set_default {
service=nginx
id=22005
install_cert
}




case $install_target in
smtp)
 install_smtp
 ;;
imap)
 install_imap
 ;;
ftp)
 install_ftp
 ;;
ivpn)
 install_ivpn
 ;;
email)
  install_email
  ;;
default)
  install_smtp
  install_imap
  install_ftp
  install_email
  set_default
  ;;
esac