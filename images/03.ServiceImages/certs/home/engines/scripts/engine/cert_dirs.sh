

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

type_path=""
ca_path=$ca_name
if ! test -z $cert_type
 then
  if test $cert_type = live
   then
    ca_path=""
    type_path=live
    store=${owner_type}s/$owner/${item_type}s/
  elif test $cert_type = external_ca
   then
    type_path=external_ca
    ca_path=""
  elif test $cert_type = imported
   then
    type_path=imported
    ca_path=""
  fi   
fi
if test -z $ca_path
 then
   item_dir=$StoreRoot/$type_path/${store}/${item_type}s/
 else
  item_dir=$StoreRoot/$ca_path/${store}/${item_type}s/
fi   

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

export country state city organisation person
}

   