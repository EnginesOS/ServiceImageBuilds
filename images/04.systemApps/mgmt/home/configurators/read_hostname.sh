#!/bin/bash

fqdn=`hostname`
hostname=`echo $fqdn | cut -f1 -d.`
domain_name=`echo $fqdn | cut -f2- -d.`

echo '{"'hostname'":"'$hostname'","'domain_name'":"'$domain_name'"}'


exit 0