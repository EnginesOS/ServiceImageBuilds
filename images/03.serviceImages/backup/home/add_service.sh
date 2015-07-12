#!/bin/bash


service_hash=$1



. /home/engines/scripts/functions.sh

echo $1 >/home/configurators/saved/system_backup




 echo "$*" >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/


dest=$dest_proto://$dest_address/$dest_folder
user=$dest_user
pass=$dest_pass

			if test $# -get 1
				then
				
				fi 

	case $src_type in
		engine)
		
		;;
		
						mkdir -p $Backup_ConfigDir/system
						cat /home/tmpl/duply_sql_pre >  $Backup_ConfigDir/system/pre
                		cp /home/tmpl/duply_sql_post  $Backup_ConfigDir/system/post
                		chmod u+x $Backup_ConfigDir/system/pre
                		chmod u+x $Backup_ConfigDir/system/post
                		
                		cp /home/tmpl/duply_conf $Backup_ConfigDir/system/conf
                		src=/backup_src/engines
                		echo "SOURCE='$src'" >>$Backup_ConfigDir/system/conf

echo "TARGET='$dest'" >>$Backup_ConfigDir/system/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/system/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/system/conf












service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment



#args backupname src_url dest_url
#src_url engine:fs:volume or engine:mysql|pgsql|..:user:pass@host/dbname
#publify publify:fs:publifyfs
#dest_url proto:user:pass@host/dir
#file:::/backups/
#ftp:back:backup@somehost.domain.com/dir

 echo "$*" >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/
#
# makebackconf.sh  publifydb  publify:mysql:publifydb:publifydb@mysql.engines.internal/publifydb ftp:engback:back_eng@203.14.203.141/publifydb
#bash makebackconf.sh publify publify:fs:publifyfs ftp:engback:back_eng@203.14.203.141/publify


#For Engine
#name
#parent_engine
#dest_proto
#dest_folder
#dest_address
#dest_user
#dest_pass
#:parent_engine



mkdir -p $Backup_ConfigDir/$1

        if test $src_type = "fs"
          then
                src=/backup_src/volumes/$src_vol
          else
echo "src type $src_type"
#                part=`echo $2 | cut -f 1 -d@`
#                flavor=`echo $part | cut -f 2 -d:`
#                dbuser=`echo $part | cut -f 3 -d:`
#                dbpass=`echo $part | cut -f 4 -d:`

#                end=`echo $2 | cut -f 2 -d@`
#                dbhost=`echo $end |cut -f 1 -d/`
#                dbname=`echo $end |cut -f 2 -d/`

                echo "#!/bin/sh " > $Backup_ConfigDir/$1/pre
                echo "dbflavor=$flavor" >> $Backup_ConfigDir/$1/pre
                echo "dbhost=$dbhost" >> $Backup_ConfigDir/$1/pre
                echo "dbname=$dbname" >> $Backup_ConfigDir/$1/pre
                echo "dbuser=$dbuser" >> $Backup_ConfigDir/$1/pre
                echo "dbpass=$dbpass" >> $Backup_ConfigDir/$1/pre
                cat /home/tmpl/duply_sql_pre >  $Backup_ConfigDir/$1/pre

                cp /home/tmpl/duply_sql_post  $Backup_ConfigDir/$1/post
                chmod u+x $Backup_ConfigDir/$1/pre
                 chmod u+x $Backup_ConfigDir/$1/post
                 src=/home/backup/sql_dumps
                
        fi

#dest_proto=`echo $3 |cut -f1 -d:`

        if test $dest_proto = "file"
                then
                 #path=`echo $3 |cut -f4 -d:`
                  dest=/var/lib/engines/local_backup_dests/$path
          else
                #first=`echo $3 |cut -f1 -d@`
                #user=`echo $first |cut -f2 -d:`
                #pass=`echo $first |cut -f3 -d:`
                #rest=`echo $3 |cut -f2 -d@`
                #host=`echo $rest |cut -f1 -d/`
                #path=`echo $rest |cut -f2 -d/`
                dest="$dest_proto://$host/$path"
        fi




cp /home/tmpl/duply_conf $Backup_ConfigDir/$1/conf

echo "SOURCE='$src'" >>$Backup_ConfigDir/$1/conf
echo "TARGET='$dest'" >>$Backup_ConfigDir/$1/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/$1/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/$1/conf
                 