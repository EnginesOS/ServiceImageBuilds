#!/bin/bash


service_hash=$1



. /home/engines/scripts/functions.sh

echo $1 >/home/configurators/saved/system_backup




 echo "$*" >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/


dest=$dest_proto://$dest_address/$dest_folder
user=$dest_user
pass=$dest_pass

	#		if test $# -get 1
	#			then
	#			
	#			fi 

	case $src_type in
		engine)		
			
						


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


#For Engine
#name
#parent_engine
#dest_proto
#dest_folder
#dest_address
#dest_user
#dest_pass
#:parent_engine

dirname= $Backup_ConfigDir/$parent_engine_$name_$src_type

mkdir -p $dirname

        if test $src_type = "fs"
          then
               	src=/backup_src/volumes/$src_vol
          elsif test $src_type = 'engine'
       
    			src=/backup_src/engines/$parent_engine  
           else
				echo "src type $src_type"
                echo "#!/bin/sh " >  $dirname/pre
                echo "dbflavor=$flavor" >>  $dirname/pre
                echo "dbhost=$dbhost" >>  $dirname/pre
                echo "dbname=$dbname" >>  $dirname/pre
                echo "dbuser=$dbuser" >>  $dirname/pre
                echo "dbpass=$dbpass" >>  $dirname/pre
                cat /home/tmpl/duply_sql_pre >>   $dirname/pre
                cp /home/tmpl/duply_sql_post   $dirname/post
                chmod u+x  $dirname/pre
                chmod u+x  $dirname/post
                src=/home/backup/sql_dumps                
        fi

#dest_proto=`echo $3 |cut -f1 -d:`

        if test $dest_proto = "file"
                then
                 #path=`echo $3 |cut -f4 -d:`
                  dest=/var/lib/engines/local_backup_dests/$path         
        elif test $dest_proto = "s3"	
        	then
			   dest_proto="s3+http://" 
	    else
              dest="$dest_proto://$host/$path"
	fi

cp /home/tmpl/duply_conf  $dirname/conf

echo "SOURCE='$src'" >> $dirname/conf
echo "TARGET='$dest'" >> $dirname/conf
echo "TARGET_USER='$user'"  >> $dirname/conf
echo "TARGET_PASS='$pass'"  >> $dirname/conf

if test $src_type = 'engine'
  then
	cp -rp $dirname ${dirname}_db
	mv $dirname ${dirname}_fs
	cd $dirname_db
	dirname=$dirname_db
	echo "#!/bin/sh " >  $dirname/pre
                echo "dbflavor=$flavor" >>  $dirname/pre
                echo "dbhost=$dbhost" >>  $dirname/pre
                echo "dbname=$dbname" >>  $dirname/pre
                echo "dbuser=$dbuser" >>  $dirname/pre
                echo "dbpass=$dbpass" >>  $dirname/pre
                cat /home/tmpl/duply_sql_pre >>   $dirname/pre
                cp /home/tmpl/duply_sql_post   $dirname/post
                chmod u+x  $dirname/pre
                chmod u+x  $dirname/post
                src=/home/backup/sql_dumps         
                       cat $dirname/conf | grep -v SOURCE >/tmp/t
                       mv /tmp/t $dirname/conf
           echo "SOURCE='$src'" >> $dirname/conf
   fi
           
                 