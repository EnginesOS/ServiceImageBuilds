#!/bin/bash 
 
 

src_type=volume
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


