

if test -z $ca_name
 then
  ca_name=system
fi

StoreRoot=/home/certs/store
setup_dir=$StoreRoot/$ca_name/saved
pending_csr_dir=$StoreRoot/$ca_name/pending_csr
completed_csr_dir=$StoreRoot/$ca_name/completed_csr
InstalledRoot=$StoreRoot/live
ImportedRoot=$StoreRoot/imported
CERT_DEFAULTS_FILE=$StoreRoot/default_cert_details



resolve_key_dir()
{
item_type=key
resolve_item_dir
key_dir=$item_dir
export key_dir
}

resolve_cert_dir()
{
item_type=cert
resolve_item_dir
cert_dir=$item_dir
export cert_dir
}

resolve_item_dir()
{
#if test $cert_type = generated
# then
#   store=/${item_type}s/${owner_type}s/$owner/
#    if test $owner_type = service
#     then
#      cert_type=live
#      store=${owner_type}s/$owner/${item_type}s/
#    fi   
#elif test $cert_type = user
# then
#   cert_type=user
#el
if ! test -z $cert_type
 then
if test $cert_type = live
 then
   ca_name=""
   store=${owner_type}s/$owner/${item_type}s/
elif test $cert_type = external_ca
 then
   ca_name=""
elif test $ca_name = external_ca
 then
   cert_type=""
elif $cert_type = user
then
  cert_type=""
elif $cert_type = generated
then
  cert_type=""
fi  
fi
item_dir=$StoreRoot/$ca_name/$cert_type/${store}/${item_type}s/

}

load_cert_defaults()
{
. $CERT_DEFAULTS_FILE
if test -z "$country"
 then
  country="$_country"
fi
if test -z "$state"
 then
  state="$_state"
fi  
if test -z "$city"
 then
  city="$_city"
fi
if test -z "$person"
 then
  person="$_person"
fi
if test -z "$organisation"
 then
  organisation="$_organisation"
fi
}

   