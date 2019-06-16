
StoreRoot=/home/certs/store
setup_dir=$StoreRoot/saved
pending_csr_dir=$StoreRoot/pending_csr
completed_csr_dir=$StoreRoot/completed_csr
InstalledRoot=/home/certs/store/live
ImportedRoot=/home/certs/store/imported
CERT_DEFAULTS_FILE=$StoreRoot/default_cert_details
if test -z $ca_name
 then
  $ca_name=system
fi