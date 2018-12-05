#!/bin/sh

 . /home/engines/functions/checks.sh
 
required_values="log_file_path parent_engine"
check_required_values

rm /home/saved/$parent_engine/$service_handle.entry

