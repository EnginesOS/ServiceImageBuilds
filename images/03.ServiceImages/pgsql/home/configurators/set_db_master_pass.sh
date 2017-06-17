#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

echo $1 |grep = >/dev/null
if test $? -ne 0
 then
   exit
fi

        
if test -n $db_master_pass
 then  
    db_master_pass=`echo $db_master_pass|sed "/'/s///g"`
	echo  "alter user rma with PASSWORD '$db_master_pass';" | psql postgres postgres          			
fi
 

