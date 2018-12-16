#!/bin/sh

login=`cat/home/engines/scripts/configurators/saved/login`
provide=`cat/home/engines/scripts/configurators/saved/provider`
domain_name=`cat/home/engines/scripts/configurators/saved/domain_name`
password=`cat/home/engines/scripts/configurators/saved/password`
echo '{
	"provider":"'$provider'",
	"login":"'$login'",
	"domain_name":"'$domain_name'",
	"password":"'$password'"}'

fi
exit 0