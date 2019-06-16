#!bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
first=1
echo -n '{"CA":['
for ca in `ls $StoreRoot/private/ca/keys/ |sed "/_CA\.key.*/s///g"`
do
  if test $first -eq 0
   then
    echo -n ,
  else
   first=0
  fi 
	echo -n '"'$ca'"'
 echo ']}'
 done
