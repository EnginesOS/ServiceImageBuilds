#!/bin/bash

install_target=$1
cert_name=$2
domain_name=$3

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
function install_pqsql {
service=pqsql
id=22005
install_cert
}
function install_mysql {
service=mysql
id=22005
install_cert
}
function install_nginx {
service=nginx
id=22005
mkdir -p /home/certs/store/services/${service}/certs/
mkdir -p /home/certs/store/services/${service}/keys/
#need domain name to save to
cp /home/certs/store/public/certs/${cert_name}.crt /home/certs/store/services/${service}/certs/${domain_name}.crt 
cp /home/certs/store/public/keys/${cert_name}.key /home/certs/store/services/${service}/keys/${domain_name}.key
chown $id /home/certs/store/services/${service}/keys/${cert_name}.key /home/certs/store/services/${service}/certs/${domain_name}.crt 
chmod og-rw /home/certs/store/services/${service}/keys/${cert_name}.key /home/certs/store/services/${service}/certs/${domain_name}.crt 

}

function set_default {
service=nginx
id=22005

cp /home/certs/store/public/certs/${cert_name}.crt /home/certs/store/services/${service}/certs/default.crt 
cp /home/certs/store/public/keys/${cert_name}.key /home/certs/store/services/${service}/keys/default.key
chown $id /home/certs/store/services/${service}/keys/default.key /home/certs/store/services/${service}/certs/default.crt 
chmod og-rw /home/certs/store/services/${service}/keys/default.key /home/certs/store/services/${service}/certs/default.crt 

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
mysql)
install_mysql
;;
pqsql)
install_pqsql
;;

default)
  install_smtp
  install_imap
  install_ftp
  install_email
  install_ivpn
  install_mysql
  install_pqsql
  domain_name=default
  set_nginx  
  ;;
 *)
   set_nginx
  ;;
esac