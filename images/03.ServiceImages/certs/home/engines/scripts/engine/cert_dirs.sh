
StoreRoot=/home/certs/store
setup_dir=$StoreRoot/saved/$ca_path
pending_csr_dir=$StoreRoot/pending_csr/$ca_path
completed_csr_dir=$StoreRoot/completed_csr/$ca_path
InstalledRoot=/home/certs/store/live
ImportedRoot=/home/certs/store/imported
CERT_DEFAULTS_FILE=$StoreRoot/default_cert_details

if test -z $ca_name
 then
  ca_name=system
fi
if test $ca_name = system
 then
  ca_path=""
 else
  ca_path=$ca_name
fi

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
if test $cert_type = generated
 then
   store=/${item_type}s/${owner_type}s/$owner/
    if test $owner_type = service
     then
      cert_type=live
      store=${owner_type}s/$owner/${item_type}s/
    fi   
elif test $cert_type = user
 then
   cert_type=user
elif test $cert_type = live
 then
   store=${owner_type}s/$owner/${item_type}s/
elif test $cert_type = external_ca
 then
   store=/${item_type}s/
fi  

item_dir=$StoreRoot/$cert_type/${store}/${item_type}s/

}   