#!/bin/sh



required_values="db_master_pass"
check_required_values  
        
if test -n $db_master_pass
 then  
    db_master_pass=`echo $db_master_pass|sed "/'/s///g"`
	echo  "alter user rma with PASSWORD '$db_master_pass';" | psql postgres postgres          			
fi
 

