#!/bin/sh 
. /home/engines/scripts/engine/backup_dirs.sh
. /home/engines/scripts/engine/backup_functions.sh

 . /home/engines/functions/checks.sh
check_required_values

backup_id=${parent}_${backup_name}_${src_type}
dirname=${Backup_ConfigDir}/$backup_id

echo ADD Backup $1

service_backup_cmd='curl -k https://172.17.0.1:2380/v0/backup' 

echo dirname $dirname

if test -z $2
 then
   if test -d $dirname
     then 
      rm -rf $dirname
   fi
  mkdir -p $dirname
fi  

export dirname

echo -n $backup_type > $dirname/backup_type

if ! test -z "$email"
then
 echo $email >$dirname/backup_reports_email 	
fi

if test $backup_type = incr
then
 dir=`echo $volume_src |sed "/\/var\/lib\/engines\//s///"`
 src=/backup_src/volumes/$dir
else
 echo $backup_type >>/tmp/bt
 mkdir -p /tmp/backup
 src=/tmp/backup
 echo $1 > $dirname/pre_cmd_path
 if ! test -f $dirname/pre
  then
   cat /home/engines/templates/backup/duply_pre > $dirname/pre
   cat /home/engines/templates/backup/duply_post > $dirname/post
  fi
tp=`dirname $1`
tp=`basename $tp`
sh=`basename $1`
backup_name=${backup_id}_$tp_$sh.backup
  echo " $service_backup_cmd/engine/$1 > /tmp/backup/${backup_name} " >> $dirname/pre    
fi
if ! test -f $dirname/conf
 then
    write_duply_config
fi    

chmod u+x  $dirname/pre
chmod u+x  $dirname/post
chmod og-rwx $dirname
