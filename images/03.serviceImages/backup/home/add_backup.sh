#!/bin/bash 
 



echo name $backup_name
echo parent $parent
echo src_type $src_type
dirname=${parent}_${backup_name}_${src_type}
dirname=${Backup_ConfigDir}/$dirname


echo dirname $dirname
if test -d $dirname
 then 
   rm -rf $dirname
  fi
mkdir -p $dirname

export dirname

	if ! test -z "$email"
 then
 	echo $email >$dirname/email 	
 fi
 #if type differential
#				dir=`echo $volume_src |sed "/\/var\/lib\/engines\//s///"`
 #              	src=/backup_src/volumes/$dir
 #else
 mkdir -p /tmp/backup
 src=/tmp/backup
  echo $1 >   $dirname/pre_cmd_path
   cat /home/tmpl/duply_pre  >   $dirname/pre
  cat /home/tmpl/duply_post  >    $dirname/post
    
#fi
        if test $dest_proto = "file"
                then
                 #path=`echo $3 |cut -f4 -d:`
                  dest=/var/lib/engines/local_backup_dests/$dest_folder         
        elif test $dest_proto = "s3"	
        	then
			   dest_proto="s3+http://" 
	    else
              dest="$dest_proto://$dest_address/$dest_folder"
	fi


/home/prep_conf.sh  $dirname/conf

echo "SOURCE='$src'" >> $dirname/conf
echo "TARGET='$dest'" >> $dirname/conf
echo "TARGET_USER='$dest_user'"  >> $dirname/conf
echo "TARGET_PASS='$dest_pass'"  >> $dirname/conf

 
  chmod u+x  $dirname/pre
  chmod u+x  $dirname/post