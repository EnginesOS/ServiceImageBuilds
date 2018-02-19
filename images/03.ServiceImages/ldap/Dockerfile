FROM engines/servicebase:$release
Maintainer image.maintainer@engines.onl

RUN apt-get -y update &&\
	adduser -q --disabled-password -uid 22030 openldap &&\
	usermod -G containers -a openldap &&\
	/home/no_init.sh &&\	
	echo slapd slapd/no_configuration boolean true | debconf-set-selections &&\	
	apt-get -y install sasl2-bin \
				       libsasl2-2  \
				       libsasl2-modules-gssapi-mit \
				       libsasl2-modules-ldap \
				       krb5-config \
				       krb5-user \
				       slapd \
				       ldap-utils 

ADD home home

RUN	/home/post_build_clean.sh &&\
 	mkdir -p /var/log/apache2 &&\
 	chown www-data /var/log/apache2  &&\
 	mkdir /var/run/slapd &&\
 	chown openldap /var/run/slapd  &&\
 	usermod -a -G sasl openldap
 	

ADD  sudoers /etc/sudoers.d/ldap
ADD  src/ldap.conf /etc/ldap/
#ADD  src/slapd.d /home/slapd.d

#This is not the final filename but sasl must be disabled until ldap schema is ready
COPY src/sasl2_slapd.conf /usr/lib/sasl2/
COPY src/slapd.conf /home/engines/etc

RUN  chmod -R go-rw /etc/sudoers /etc/sudoers.d/ 

ENV ContUser openldap
ENV ContGrp openldap

USER openldap

CMD ["/home/engines/scripts/startup/start.sh"]