#!/bin/bash

install_target=$1
cert_name=$2
domain_name=$3

function install_cert {
if test -z ${dest_name}
 then 
 	dest_name=engines
fi
mkdir -p /home/certs/store/services/${service}/certs/
mkdir -p /home/certs/store/services/${service}/keys/

cp /home/certs/store/public/certs/${cert_name}.crt /home/certs/store/services/${service}/certs/${dest_name}.crt 
cp /home/certs/store/public/keys/${cert_name}.key /home/certs/store/services/${service}/keys/${dest_name}.key
chown $id /home/certs/store/services/${service}/keys/${dest_name}.key /home/certs/store/services/${service}/certs/${dest_name}.crt 
chmod og-rw /home/certs/store/services/${service}/keys/${dest_name}.key 
chmod og-w /home/certs/store/services/${service}/certs/${dest_name}.crt 
}

function install_system {
dest_name=engines
service=system
id=21000
install_cert
}

function install_smtp {
dest_name=engines
service=smtp
id=22003
install_cert
}

function install_ftp {
dest_name=engines
service=ftp
id=22010
install_cert
}

function install_imap {
dest_name=engines
service=imap
id=22013
install_cert
}

function install_ivpn {
service=ivpn
id=22031
dest_name=ipvpn
install_cert
}

function install_email {
dest_name=engines
service=email
id=22005
install_cert
}
function install_pqsql {
dest_name=engines
service=pqsql
id=22002
install_cert
}
function install_mysql {
dest_name=engines
service=mysql
id=22006
install_cert
}
function install_mgmt  {
dest_name=engines
service=mgmt
id=22050
install_cert
}
function install_nginx {
service=nginx
id=22005
dest_name=${domain_name}
install_cert
}

function set_default {
domain_name=default

service=nginx
id=22005
mkdir -p /home/certs/store/services/${service}/certs/
mkdir -p /home/certs/store/services/${service}/keys/
cp /home/certs/store/public/certs/${cert_name}.crt /home/certs/store/services/${service}/certs/default.crt 
cp /home/certs/store/public/keys/${cert_name}.key /home/certs/store/services/${service}/keys/default.key
chown $id /home/certs/store/services/${service}/keys/default.key /home/certs/store/services/${service}/certs/default.crt 
chmod og-rw /home/certs/store/services/${service}/keys/default.key 
chmod og-w /home/certs/store/services/${service}/certs/default.crt 

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
mgmt)
  install_mgmt
  ;;
pqsql)
  install_pqsql
  ;;
system)
 install_system
 ;;
default)
  install_system
  install_smtp
  install_imap
  install_ftp
  install_email
  install_mysql
  install_pqsql 
  install_mgmt 
  domain_name=default
  set_default  
  ;;
*)
  install_nginx
  ;;
esac