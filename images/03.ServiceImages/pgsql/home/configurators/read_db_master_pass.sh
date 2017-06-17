#!/bin/bash

if test -f /home/configurators/saved/db_master_pass
 then
	cat /home/configurators/saved/db_master_pass
else
    echo '{"db_master_pass":"Not Saved"}'	
fi

