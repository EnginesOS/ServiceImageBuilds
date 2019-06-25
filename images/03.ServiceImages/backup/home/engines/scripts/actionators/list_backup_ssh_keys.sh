#!/bin/sh


keys_dir=/home/backup/.ssh


ls $keys_dir/ |grep -v pub 

exit 0