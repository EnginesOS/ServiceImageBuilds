#!/bin/bash


echo set_default.sh $*

ca_name=$1
cert_name=$2
install_target=$3

. /home/engines/scripts/engine/cert_dirs.sh

if test install_target = default
 then
  install_target = all
fi

echo install target $install_target
 
function install_service {
 echo Install Service install_target=$target
dest_name=`basename $install_target`

err=`sudo -n  /home/engines/scripts/engine/sudo/_assign_certificate.sh  ${ca_name} ${cert_name} ${install_target} ${dest_name}`
r=$?
 if test $r -ne 0
  then
  	echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
fi


}

targets="system_services/system services/smtp services/ftp services/email services/imap services/mysql services/pgsql services/mgmt services/wap services/control"

case $install_target in

all)
	echo default for all
   for install_target in $targets
    do    
      echo install_target=$target
      install_service
    done  
  ;;
*)
   install_service
   ;;
esac

exit $r