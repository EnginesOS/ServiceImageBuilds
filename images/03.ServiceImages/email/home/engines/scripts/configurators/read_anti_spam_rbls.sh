#!/bin/sh

config_dir=/home/engines/scripts/configurators/saved/antispam/

if test -f ${config_dir}/zen.spamhaus.org
 then
   zen_spamhaus_org=true
 else
    zen_spamhaus_org=false
fi

if test -f ${config_dir}/bl.spamcop.net
 then
   bl_spamcop_net=true
 else
    bl_spamcop_net=false
fi

if test -f ${config_dir}/cbl.abuseat.org
 then
   cbl_abuseat_org=true
 else
    cbl_abuseat_org=false
fi

if test -f ${config_dir}/dnsbl.njabl.org
 then
   dnsbl_njabl_org=true
 else
    dnsbl_njabl_org=false
fi

if test -f ${config_dir}/dnsbl.sorbs.net
 then
   dnsbl_sorbs_net=true
 else
    dnsbl_sorbs_net=false
fi

if test -f ${config_dir}/dsn.rfc-ignorant.org
 then
   dsn_rfc-ignorant_org=true
 else
    dsn_rfc-ignorant_org=false
fi
 
 echo '"{"zen_spamhaus_org":"'${zen_spamhaus_org}'",
 	"bl_spamcop_net":"'${bl_spamcop_net}'",
 	"cbl_abuseat_org":"'${cbl_abuseat_org}'",
 	"dnsbl_njabl_org":"'${dnsbl_njabl_org}'",
 	"dnsbl_sorbs_net":"'${dnsbl_sorbs_net}'",
 	"dsn_rfc-ignorant_org":"'${dsn_rfc-ignorant_org}'"}'


exit 0
