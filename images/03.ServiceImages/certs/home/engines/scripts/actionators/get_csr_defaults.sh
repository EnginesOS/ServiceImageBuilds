#!/bin/sh

. /home/certs/store/default_cert_details
echo '{"person":"'$_person'",
		"organisation":"'$_organisation'",
		"city":"'$_city'",
		"state":"'$_state'",
		"country":"'$_country'"}'
	