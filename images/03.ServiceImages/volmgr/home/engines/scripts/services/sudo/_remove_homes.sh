#!/bin/sh
for user in `cat -` do
if ! test -z $user
 then  
  if ! test -z $parent_engine
   then
     rm -r /var/lib/engines/home/$user/$parent_engine
  else
   echo "No Parent var"   
  fi
else
 echo "No user var"  
fi

done 
#if test -d /var/fs/local/${parent_engine}/${service_name} 
# then
#	echo "rm /var/fs/local/${parent_engine}/${service_name}"
#	rm -r  /var/fs/local/${parent_engine}/${service_name}
#  else
#  	echo "No such dir /var/fs/local/${parent_engine}/${service_name}"
#  fi
#exit 0	
#
