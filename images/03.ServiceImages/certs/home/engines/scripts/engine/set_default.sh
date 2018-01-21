#!/bin/bash
#set_default.sh ${install_target} ${cert_type} ${cert_name} 

function install_service {

dest_name=`basename $install_target`
err=`sudo -n  /home/engines/scripts/engine/_install_target.sh ${install_target} ${cert_type} ${cert_name} ${install_target}
r=$?
 if $r -ne 0
  then
  	echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
fi
exit $r

}

targets="system_services/system services/smtp services/ftp services/emailservices/ services/mysql services/pgsql services/mgmt services/wap services/control"
case $install_target in $targets

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
