#!/bin/sh

#. /home/engines/functions/params_to_env.sh
#PARAMS_FILE=/home/engines/scripts/configurators/saved/rbl
#params_to_file_and_env


/home/engines/scripts/configurators/check_anti_spam_setting.sh zen.spamhaus.org ${zen_spamhaus_org}
/home/engines/scripts/configurators/check_anti_spam_setting.sh bl.spamcop.net ${bl_spamcop_net}
/home/engines/scripts/configurators/check_anti_spam_setting.sh cbl.abuseat.org ${cbl_abuseat_org}
/home/engines/scripts/configurators/check_anti_spam_setting.sh dnsbl.njabl.org ${dnsbl_njabl_org}
/home/engines/scripts/configurators/check_anti_spam_setting.sh dnsbl.sorbs.net ${dnsbl_sorbs_net}
/home/engines/scripts/configurators/check_anti_spam_setting.sh dsn.rfc-ignorant.org ${dsn_rfc-ignorant_org}

sudo /home/engines/scripts/configurators/sudo/rebuild_main.sh
 
exit 0
