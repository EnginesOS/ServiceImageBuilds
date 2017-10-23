#!/bin/bash


CURL_OPTS="-k -X PUT --header "Content-Type:application/octet-stream" --data-binary  @-"

if test -z $source
 then
	cat /tmp/system/files* |curl $CURL_OPTS https://172.17.0.1:2380/v0/restore/system/files/$replace/$section
else
  tar -xpf /tmp/system/files_* opt/engines/run/containers/$source \
  | tar -cpf - |curl $CURL_OPTS https://172.17.0.1:2380/v0/restore/system/files/$replace/$source/$section
fi
echo "Restored system $replace $source $section"

rm -r /tmp/system