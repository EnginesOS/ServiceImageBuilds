

function add_to_internal_domain {
if test -z ${hostname}
 then
	echo Error:Missing hostname
   exit 128
 fi
    
host=`echo ${hostname} | sed "/[_.]/s//-/g"`
engine=`echo ${parent_engine} | sed "/[_.]/s//-/g"`
fqdn_str=${host}.engines.internal
    
if test -z ${ip}
 then
    update_line=" update add $fqdn_str 30 CNAME ${engine}.engines.internal"
 else
   update_line=" update add $fqdn_str 30 A $ip"        
fi  

ip_reversed=`echo $ip |awk  ' BEGIN {  FS="."} {print $4 "." $3 "." $2 "." $1}'`
    
echo server 127.0.0.1 > /tmp/.dns_cmd
echo update delete $fqdn_str >> /tmp/.dns_cmd
echo send >> /tmp/.dns_cmd
echo $update_line >> /tmp/.dns_cmd
echo send >> /tmp/.dns_cmd
echo update add ${ip_reversed}.in-addr.arpa. 30 PTR $fqdn_str >> /tmp/.dns_cmd
echo send >> /tmp/.dns_cmd
nsupdate -k /etc/bind/keys/ddns.private /tmp/.dns_cmd


}