#!bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
first=1
echo -n '{"CA":['
for ca in `ls $StoreRoot/public/ca/certs/ |grep _CA.pem | sed "/_CA\.pem/s///g"`
do
  if test $first -eq 0
   then
    echo -n ,
  else
   first=0
  fi 
	echo -n '"'$ca'"'
 done
 echo ']}'
