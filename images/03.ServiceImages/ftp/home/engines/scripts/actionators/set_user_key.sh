#!/bin/sh
kf=`mktemp`
echo $user_key >$kf
sudo -n /home/engines/scripts/actionators/_set_user_keys.sh $username $kf
