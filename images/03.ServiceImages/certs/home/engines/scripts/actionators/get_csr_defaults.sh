#!/bin/sh

. /home/certs/store/default_cert_details
echo '{"person":"'$person'",
		"organisation":"'$organisation'",
		"city":"'$city'",
		"state":"'$state'",
		"country":"'$country'"}'
	