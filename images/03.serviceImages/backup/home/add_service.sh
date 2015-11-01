#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

echo $1 >/home/configurators/saved/system_backup

 echo "$*" >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/


load_service_hash_to_environment


 echo "$*" >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/


echo name $backup_name
echo parent_engine $parent_engine
echo src_type $src_type
dirname=${parent_engine}_${backup_name}_${src_type}
dirname=${Backup_ConfigDir}/$dirname


echo dirname $dirname
if test -d $dirname
 then 
   rm -rf $dirname
  fi
mkdir -p $dirname

        if test $src_type = "fs"
          then
               	src=/backup_src/volumes/$src_vol
          elif test $src_type = 'engine'
       	   then
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
  
   if test -d ${dirname}_fs
		 	then
		 		rm -rf ${dirname}_fs
		 fi
		 if test -d ${dirname}_db
		 	then
		 		rm -rf ${dirname}_db
		 fi		 
		 
	cp -rp $dirname ${dirname}_db
	mv $dirname ${dirname}_fs
	cd ${dirname}_db
	dirname=${dirname}_db
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
           
                 