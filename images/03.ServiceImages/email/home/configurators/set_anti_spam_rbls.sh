#!/bin/bash


cat - >/home/configurators/saved/rbl
cat  echo $service_hash  | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


    
/home/configurators/check_anti_spam_setting.sh zen.spamhaus.org ${zen_spamhaus_org}
/home/configurators/check_anti_spam_setting.sh bl.spamcop.net ${bl_spamcop_net}
/home/configurators/check_anti_spam_setting.sh cbl.abuseat.org ${cbl_abuseat_org}
/home/configurators/check_anti_spam_setting.sh dnsbl.njabl.org ${dnsbl_njabl_org}
/home/configurators/check_anti_spam_setting.sh dnsbl.sorbs.net ${dnsbl_sorbs_net}
/home/configurators/check_anti_spam_setting.sh dsn.rfc-ignorant.org ${dsn_rfc_ignorant_org}

sudo /home/configurators/rebuild_main.sh
   	
   	
	

 
exit 0
