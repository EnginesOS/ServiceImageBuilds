

add_to_internal_domain()
 {
if test -z ${hostname}
 then
	echo Error:Missing hostname
   exit 128
 fi
    
host=${hostname}
engine=${parent_engine}
fqdn_str=${host}.engines.internal
    
dns_cmd_file=`mktemp`

if test -z $ttl
 then
  ttl=30
fi   
   
if test -z $record_type
 then
  if test -z ${ip}
   then
    update_line=" update add $fqdn_str $ttl CNAME ${engine}.engines.internal"
   else
     update_line=" update add $fqdn_str $ttl A $ip"        
  fi  
elif test $record_type = custom
 then
    no_inarpra=y
   update_line="update add $fqdn_str 30 $record"
fi 

    
echo server 127.0.0.1 > $dns_cmd_file
echo update delete $fqdn_str >> $dns_cmd_file
echo send >> $dns_cmd_file
echo $update_line >> $dns_cmd_file
echo send >> $dns_cmd_file
 cp  $dns_cmd_file /tmp/add_$fqdn_str

if test -z $no_inarpra 
 then
    ip_reversed=`echo $ip |awk  ' BEGIN {  FS="."} {print $4 "." $3 "." $2 "." $1}'`
	echo update add ${ip_reversed}.in-addr.arpa. $ttl PTR $fqdn_str >> $dns_cmd_file
	echo send >> $dns_cmd_file
fi
 cp  $dns_cmd_file /tmp/add_inapra_$fqdn_str

nsupdate -k /etc/bind/keys/ddns.private $dns_cmd_file
r=$?
if test $r -eq 0
 then
   rm $dns_cmd_file
   echo Success
 else
   file=`cat $dns_cmd_file`
   echo Error:With nsupdate $file
fi
export r

}