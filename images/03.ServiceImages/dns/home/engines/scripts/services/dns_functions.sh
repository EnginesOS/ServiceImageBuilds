

function add_to_internal_domain {
if test -z ${hostname}
 then
	echo Error:Missing hostname
   exit 128
 fi
    
host=`echo ${hostname} | sed "/[_.]/s//-/g"`
engine=`echo ${parent_engine} | sed "/[_.]/s///g"`
fqdn_str=${host}.engines.internal
    
dns_cmd_file=`mktemp`
   
if test -z ${ip}
 then
    update_line=" update add $fqdn_str 30 CNAME ${engine}.engines.internal"
 else
   update_line=" update add $fqdn_str 30 A $ip"        
fi  

ip_reversed=`echo $ip |awk  ' BEGIN {  FS="."} {print $4 "." $3 "." $2 "." $1}'`
    
echo server 127.0.0.1 > $dns_cmd_file
echo update delete $fqdn_str >> $dns_cmd_file
echo send >> $dns_cmd_file
echo $update_line >> $dns_cmd_file
echo send >> $dns_cmd_file
if test -z $no_inarpra 
 then
	echo update add ${ip_reversed}.in-addr.arpa. 30 PTR $fqdn_str >> $dns_cmd_file
	echo send >> $dns_cmd_file
fi

nsupdate -k /etc/bind/keys/ddns.private $dns_cmd_file

#rm $dns_cmd_file

}