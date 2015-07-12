#!/bin/sh


sudo syslogd -R syslog.engines.internal:5140


PID_FILE=/var/run/ftpd.pid
export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags
	
	
service_hash=`ssh -p 2222  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/.ssh/access_rsa auth@auth.engines.internal /home/auth/static/scripts/ftp/get_access.sh`


n=1

echo $service_hash |grep = >/dev/null
        if test $? -ne 0
        then
        		echo Error:No Arguments
                
        fi

#Strip preceeding and trailing :
new=`echo $service_hash | sed "/^:/s///" |  sed "/:$/s///"`
echo new
echo $new
service_hash=$new



fcnt=`echo $service_hash| grep -o : |wc -l`
echo $res
#fcnt=${#res}
fcnt=`expr $fcnt + 1`

        while test $fcnt -ge $n
        do
                nvp="`echo $service_hash |cut -f$n -d:`"
                n=`expr $n + 1`
                name=`echo $nvp |cut -f1 -d=`
                value=`echo $nvp |cut -f2 -d=`
                name_length=`echo  $name |wc -c`
                if test $name_length -gt 0
                	then
                	echo $name=$value
                		export $name="$value"
                	fi
        done

	echo "	SQLConnectInfo $database_name@$db_host $db_username $db_password " >> /etc/proftpd/sql.conf
	echo  "</IfModule> " >> /etc/proftpd/sql.conf


sudo /usr/sbin/proftpd -n &
 touch  /engines/var/run/flags/startup_complete
wait 
sudo /home/engines/scripts/_kill_syslog.sh

rm /engines/var/run/flags/startup_complete