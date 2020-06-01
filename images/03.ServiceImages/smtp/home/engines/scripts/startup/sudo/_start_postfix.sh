#!/bin/sh
setup() 
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


dirs_to_create="/etc/postfix/maps/ /etc/postfix/maps/aliases/"
dir_ownership=postfix

create_dirs

postfix set-permissions

chown postfix /home/engines/scripts/configurators/saved/
chown opendkim /etc/opendkim/keys 
}

init_dbs()
{
#!/bin/sh

sudo -n /home/engines/scripts/startup/sudo/_setup_dirs.sh

for map_file in transport generic smarthost_passwd aliases/aliases
 do 
  if ! test -f /etc/postfix/${map_file}.db
   then
     /home/engines/scripts/engine/sudo/_postmap.sh ${map_file}
  fi  
done 
}

start()
{
  if test -f /var/spool/postfix/pid/master.pid
   then
	rm /var/spool/postfix/pid/master.pid
  fi
  /usr/lib/postfix/sbin/master -w
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


}

if test -z $1
 then
  1=start
fi

case $1 in
 start)
  start
 prepare)
   setup
esac
