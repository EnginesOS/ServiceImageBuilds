FROM engines/servicebase:$release
Maintainer image.maintainer@engines.onl

RUN apt-get -y update &&\
	adduser -q --disabled-password -uid 22030 openldap &&\
	usermod -G containers -a openldap &&\
	/home/no_init.sh &&\	
	apt-get -y install krb5-kdc-ldap krb5-config krb5-user slapd ldap-utils apache2 libapache2-mod-php  php7.0 apache2-utils phpldapadmin &&\
	/home/configure_kerobos.sh &&\
 	/home/post_build_clean.sh &&\
 	mkdir -p /var/log/apache2 &&\
 	chown www-data /var/log/apache2 
 	
ADD home home
ADD 000-default.conf /etc/apache2/sites-enabled/
ADD ports.conf /etc/apache2/
ADD sudoers /etc/sudoers.d/ldap
ADD ldap.conf /etc/ldap/

RUN cat /home/Alias >> /etc/apache2/apache2.conf &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

ENV ContUser openldap
ENV ContGrp openldap

USER openldap

CMD ["/home/start.sh"]