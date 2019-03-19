#!/bin/sh
 . /home/engines/functions/checks.sh


  if test $type_path = "domains"
    then	
     if ! test ${domain_name} = engines.internal
      then
  	   rm /home/bind/engines/domains/${domain_name}
  	   rm  /home/bind/domain_list/*/${domain_name}
  	   rm /home/bind/engines/zones/named.conf.${domain_name}
  	   cat /home/bind/engines/domains/* > /home/bind/engines/domains.hosted
  	   kill -HUP `cat /home/engines/run/named.pid`
       echo Success
  	   exit
  	fi
  fi


if test -z ${hostname}
 then
  echo Error:Missing hostname ${hostname}
  exit -1
fi

    
#FIXME make engines.internal settable
dns_cmd_file=`mktemp`
fqdn_str=${hostname}.engines.internal
echo server 127.0.0.1 > $dns_cmd_file
echo update delete $fqdn_str >> $dns_cmd_file
echo send >> $dns_cmd_file
	
nsupdate -k /etc/bind/keys/ddns.private $dns_cmd_file
r=$?
cp  $dns_cmd_file /tmp/rm_$fqdn_str
	
if test $r -eq 0
 then
  echo Success
 else
  file=`cat $dns_cmd_file`
  echo Error:With nsupdate $file
fi
	

ip_reversed=`echo $ip |awk  ' BEGIN {  FS="."} {print $4 "." $3 "." $2 "." $1}'`
echo server 127.0.0.1 > $dns_cmd_file
echo update delete ${ip_reversed}.in-addr.arpa. >> $dns_cmd_file
echo send >> $dns_cmd_file
nsupdate -k /etc/bind/keys/ddns.private $dns_cmd_file
inr=$?
cp $dns_cmd_file /tmp/rm_inapra_$fqdn_str

if test $inr -eq 0
 then
   rm $dns_cmd_file
   echo Success
 else
   file=`cat $dns_cmd_file`
   echo Error:With nsupdate $file
fi
	
return=`expr $r + $inr`
exit $return

