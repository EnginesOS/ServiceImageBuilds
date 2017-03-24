FROM engines/servicebase:$release
Maintainer image.maintainer@engines.onl

RUN apt-get -y update;\
	adduser -q --disabled-password  -uid 22013 ldap;\
	/home/no_init.sh ;\	
	apt-get -y install slapd ldap-utils apache2  php-dev phpldapadmin;\
 	/home/post_build_clean.sh
ADD home home

	
ADD sudoers /etc/sudoers.d/ldap


RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

ENV ContUser ldap
ENV ContGrp ldap
USER ldap


CMD ["/home/start.sh"]