#/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
chown certs  `find  $StoreRoot -type d `

if ! test -d $StoreRoot/system 
 then
  mkdir $StoreRoot/system 
  cd $StoreRoot
  mv generated saved user completed_csr system
   chown certs  -R system
fi  