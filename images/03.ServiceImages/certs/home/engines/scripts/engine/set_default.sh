#!/bin/bash
#set_default.sh ${install_target} ${cert_type} ${cert_name} 
echo set_default.sh $*
install_target=$1
cert_type=$2
cert_name=$3

function install_service {

dest_name=`basename $install_target`
err=`sudo -n  /home/engines/scripts/engine/_install_target.sh ${install_target} ${cert_type} ${cert_name} ${dest_name}`
r=$?
 if test $r -ne 0
  then
  	echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
fi
exit $r

}

targets="system_services/system services/smtp services/ftp services/emailservices/ services/mysql services/pgsql services/mgmt services/wap services/control"

case $install_target in

all)
   for install_target in $targets
    do    
      install_service
    done  
  ;;
*)
   install_service
   ;;
esac
