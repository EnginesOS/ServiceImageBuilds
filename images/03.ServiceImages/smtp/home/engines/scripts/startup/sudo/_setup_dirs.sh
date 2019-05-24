#!/bin/sh
create_dirs() 
{
for dir_to_create in $dirs_to_create
do
  if ! test -d $dir_to_create
   then
     mkdir -p  $dir_to_create
  fi
  if ! test -z $dir_ownership
   then
    chown -R $dir_ownership $dir_to_create
  fi
done
}

dirs_to_create="/etc/postfix/maps/ /etc/postfix/maps/aliases/"
dir_ownership=postfix

create_dirs

postfix set-permissions

chown postfix /home/engines/scripts/configurators/saved/
chown opendkim /etc/opendkim/keys 

