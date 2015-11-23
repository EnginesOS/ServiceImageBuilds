#!/bin/bash

rm /etc/nginx/sites-enabled/http*  &> /dev/null

for site in `ls /home/consumers/saved/`
 do
 	/home/add_service.sh `cat /home/consumers/saved/$site`
 done