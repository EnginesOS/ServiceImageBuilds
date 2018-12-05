#!/bin/sh

cd /home/bind/domain_list/lan/
internal=`ls |sed "s/ /,/g"`

cd /home/bind/domain_list/wan/
external=`ls |sed "s/ /,/g"`

echo '{"internal":['$internal'],"external",['$external']}'