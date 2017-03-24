FROM engines/servicebase:$release
Maintainer image.maintainer@engines.onl

ADD Alias /tmp

RUN apt-get -y update;\
	adduser -q --disabled-password  -uid 22013 openldap;\
	/home/no_init.sh ;\	
	apt-get -y install slapd ldap-utils apache2  php-dev apache2-utils phpldapadmin;\
 	/home/post_build_clean.sh;\
 	mkdir /var/log/apache2;\
 	chown www-data /var/log/apache2 ;\
 	cat /tmp/Alias >> /etc/apache2/apache2.conf
 	
 	
ADD home home

ADD 000-default.conf /etc/apache2/sites-enabled/

ADD sudoers /etc/sudoers.d/ldap


RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

ENV ContUser openldap
ENV ContGrp openldap
USER ldap


CMD ["/home/start.sh"]