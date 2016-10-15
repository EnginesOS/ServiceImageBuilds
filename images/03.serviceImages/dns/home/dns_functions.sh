

function add_to_internal_domain {
	if test -z ${hostname}
	then
		echo Error:Missing hostname
        exit 128
    fi
    
    fqdn_str=${hostname}.engines.internal
    
  	if test -z ${ip}
	then
		 update_line=" update add $fqdn_str 30 CNAME ${parent_engine}.engines.internal"
       else
       update_line=" update add $fqdn_str 30 A $ip"        
    fi  
    
	echo server 127.0.0.1 > /tmp/.dns_cmd
	echo update delete $fqdn_str >> /tmp/.dns_cmd
	echo send >> /tmp/.dns_cmd
	echo $update_line >> /tmp/.dns_cmd
	#echo update add $fqdn_str 30 A $ip >> /tmp/.dns_cmd
	echo send >> /tmp/.dns_cmd
	nsupdate -k /etc/bind/keys/ddns.private /tmp/.dns_cmd
}