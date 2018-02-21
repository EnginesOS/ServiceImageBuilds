FROM engines/servicebase:$release

RUN adduser -q --disabled-password -uid 22013 dovecot &&\
	adduser -q --disabled-password -uid 22014 vmail &&\
	/home/no_init.sh &&\	
	apt-get -y update &&\	
	apt-get -y install dovecot-core \
					   dovecot-imapd \
					   dovecot-pop3d \
					   dovecot-sieve \
					   dovecot-lmtpd \
					   dovecot-sieve \
					   dovecot-gssapi \
					   dovecot-ldap \
					   libpam-krb5 &&\
	mkdir -p /var/mail &&\
	chown dovecot /var/mail &&\
	mkdir -p /var/run/dovecot &&\
	chown -R dovecot /var/run/dovecot/ &&\
	usermod -G containers -a dovecot &&\
 	/home/post_build_clean.sh
	
ADD src/dovecot/conf.d /etc/dovecot/conf.d
ADD src/dovecot/dovecot-ldap.conf.ext /etc/dovecot/dovecot-ldap.conf.ext
ADD sudoers /etc/sudoers.d/dovecot
ADD home home
COPY src/pam.d/dovecot /etc/pam.d/

RUN  chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER dovecot

ENV ContUser dovecot

CMD ["/home/engines/scripts/startup/start.sh"]