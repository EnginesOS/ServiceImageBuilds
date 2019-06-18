#!/bin/sh

. /home/engines/functions/checks.sh


required_values="backup_name src_type"
check_required_values

. /home/engines/scripts/engine/backup_dirs.sh

echo "$*" >>/var/log/backup/rmbackup.log

Backup_ConfigDir=/home/backup/.duply/

ts=`date`
echo "$ts:rm $*" >>/var/log/backup/addbackup.log
dirname=${parent}_${backup_name}_${src_type}
dirname=${Backup_ConfigDir}/$dirname
rm -r $dirname
export Backup_ConfigDir
export backup_name
export dest
export dest_user
export dest_pass
export parent_engine

 shift
 
