#!/bin/sh

 
build_templated_mapfile()
 {
if test -f /home/engines/templates/$map_file 
  then
   if test -f /home/postfix/$map_file
    then
	 rm /home/postfix/$map_file
	fi 
   
  cat /home/engines/templates/$map_file | while read LINE
  do
   eval echo "$LINE" >> /home/postfix/$map_file
  done
 sudo -n /home/engines/scripts/engine/sudo/_postmap.sh $map_file
fi
}
 . /home/engines/functions/checks.sh
required_values="domain_name"
check_required_values 

echo -n ${domain_name} >/home/engines/scripts/configurators/saved/domain
echo -n $deliver_local > /home/engines/scripts/configurators/saved/deliver_local
sudo -n /home/engines/scripts/engine/sudo/_set_mailname.sh smtp.${domain_name}

for map_file in generic sender_canonical aliases/aliases
do
 build_templated_mapfile
done
 

	
cp /home/engines/templates/transport /home/postfix/maps/

if test -f /etc/postfix/transport.smart 
 then
  if test `wc -c /etc/postfix/transport.smart | cut -f 1 -d" " ` -gt 4
   then
	cat /etc/postfix/transport.smart >> /home/postfix/maps/transport 
  fi
fi

if ! test -z $deliver_local 
 then
  if test  $deliver_local = true 
   then                 
	 echo ${domain_name} :[email.engines.internal]	>> /home/postfix/maps/transport 			
   fi
fi	
if test -f /etc/postfix/maps/transport.over_ride
 then
  cp /etc/postfix/maps/transport.over_ride /etc/postfix/maps/transport
  if test -f /etc/postfix/transport.smart 
   then
    if test `wc -c /etc/postfix/transport.smart | cut -f 1 -d" " ` -gt 4
     then
	   cat /etc/postfix/transport.smart >> /home/postfix/maps/transport 
    fi
  fi
fi 
sudo -n /home/engines/scripts/engine/sudo/_transport_over_ride.sh
sudo -n /home/engines/scripts/engine/sudo/_postmap.sh transport

exit $?
