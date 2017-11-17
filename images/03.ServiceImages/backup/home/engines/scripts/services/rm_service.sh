#!/bin/bash

#FixMe

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="backup_name src_type"
check_required_values

echo "$*" >>/var/log/backup/rmbackup.log

Backup_ConfigDir=/home/backup/.duply/

ts=`date`
echo "$ts:rm $*" >>/var/log/backup/addbackup.log

export Backup_ConfigDir
export backup_name
export dest
export dest_user
export dest_pass
export parent_engine

 shift
 
#while ! test -z $1
# do  
#   service_hash=$1
#   load_service_hash_to_environment
#   echo calling /home/backup_scripts/$publisher_namespace/$type_path/rm_backup.sh $1
#   /home/backup_scripts/$publisher_namespace/$type_path/rm_backup.sh $1
#   shift
# done
# 
# exit 0