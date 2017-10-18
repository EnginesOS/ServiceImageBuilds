#!/bin/bash




#reject_rbl_client zen.spamhaus.org,
#reject_rbl_client bl.spamcop.net,
#reject_rbl_client cbl.abuseat.org,
#reject_rbl_client dnsbl.njabl.org,
#reject_rbl_client dnsbl.sorbs.net,
#reject_rhsbl_sender dsn.rfc-ignorant.org,
#permit
#,check_policy_service inet:127.0.0.1:60000,permit
config_dir=/home/engines/scripts/configurators/saved/antispam/

if test -f ${config_dir}/zen.spamhaus.org
 then
   zen_spamhaus_org=true
fi

if test -f ${config_dir}/bl.spamcop.net
 then
   bl_spamcop_net=true
fi

if test -f ${config_dir}/cbl.abuseat.org
 then
   cbl_abuseat_org=true
fi

if test -f ${config_dir}/dnsbl.njabl.org
 then
   dnsbl_njabl_org=true
fi

if test -f ${config_dir}/dnsbl.sorbs.net
 then
   dnsbl_sorbs_net=true
fi

if test -f ${config_dir}/dsn.rfc-ignorant.org
 then
   dsn_rfc_ignorant_org=true
fi
 
 echo "{\"zen_spamhaus_org\":\"${zen_spamhaus_org}\",\"bl_spamcop_net\":\"${bl_spamcop_net}\",\"cbl_abuseat_org\":\"${cbl_abuseat_org}\",\"dnsbl_njabl_org\":\"${dnsbl_njabl_org}\",\"dnsbl_sorbs_net\":\"${dnsbl_sorbs_net}\",\"dsn_rfc-ignorant_org\":\"${dsn_rfc_ignorant_org}\"}"



   	
	

 
exit 0
