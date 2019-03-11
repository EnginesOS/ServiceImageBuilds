#/bin/bash
   
sites=`ls /etc/nginx/sites-enabled/ |grep -v default`
 
 for site in $sites
   do
  	 #hostname=`grep engines\.internal /etc/nginx/sites-enabled/$site  |grep -v \# |cut -f3 -d" " |cut -f1 -d:`
  	 hostname=`grep engines\.internal /etc/nginx/sites-enabled/$site  |grep -v \# | awk '{print $3}' |cut -f1 -d.`
	 resolv_ip=`nslookup $hostname |grep -e "Address: *[0-9]" |awk '{print $2}'`
	 echo $hostname $resolv_ip
        if test -z  $resolv_ip
        then
        	echo $hostname broken
        	rm /etc/nginx/sites-enabled/$site
		fi
  done

   