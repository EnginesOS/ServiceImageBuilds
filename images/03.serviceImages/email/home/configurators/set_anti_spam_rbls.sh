#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/default_domain
 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


#reject_rbl_client zen.spamhaus.org,
#reject_rbl_client bl.spamcop.net,
#reject_rbl_client cbl.abuseat.org,
#reject_rbl_client dnsbl.njabl.org,
#reject_rbl_client dnsbl.sorbs.net,
#reject_rhsbl_sender dsn.rfc-ignorant.org,
#permit
#,check_policy_service inet:127.0.0.1:60000,permit
    
/home/configurators/check_anti_spam_setting.sh zen.spamhaus.org ${zen_spamhaus_org}
/home/configurators/check_anti_spam_setting.sh bl.spamcop.net ${bl_spamcop_net}
/home/configurators/check_anti_spam_setting.sh cbl.abuseat.org ${cbl_abuseat_org}
/home/configurators/check_anti_spam_setting.sh dnsbl.njabl.org ${dnsbl_njabl_org}
/home/configurators/check_anti_spam_setting.sh dnsbl.sorbs.net ${dnsbl_sorbs_net}
/home/configurators/check_anti_spam_setting.sh dsn.rfc-ignorant.org ${dsn_rfc-ignorant_org}

/home/configurators/rebuild_main.sh
   	
   	
	

 
exit 0
