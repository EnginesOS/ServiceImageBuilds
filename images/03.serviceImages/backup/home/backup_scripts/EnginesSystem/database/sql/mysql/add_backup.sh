#!/bin/bash 
 
 src_type=mysql


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
   

        if test $dest_proto = "file"
                then
                 #path=`echo $3 |cut -f4 -d:`
                  dest=/var/lib/engines/local_backup_dests/$path         
        elif test $dest_proto = "s3"	
        	then
			   dest_proto="s3+http://" 
	    else
              dest="$dest_proto://$dest_address/$path"
	fi

cp /home/tmpl/duply_conf  $dirname/conf

echo "SOURCE='$src'" >> $dirname/conf
echo "TARGET='$dest'" >> $dirname/conf
echo "TARGET_USER='$dest_user'"  >> $dirname/conf
echo "TARGET_PASS='$dest_pass'"  >> $dirname/conf

