FROM engines/servicebase:$release

RUN adduser -q --disabled-password -uid 22013 dovecot &&\
	adduser -q --disabled-password -uid 22014 vmail &&\
	/home/no_init.sh &&\	
	apt-get -y update &&\	
	apt-get -y install dovecot-core=1:2.2.22-1ubuntu2 \
					   mysql-client \
					   dovecot-imapd=1:2.2.22-1ubuntu2  \
					   dovecot-pop3d=1:2.2.22-1ubuntu2  \
					   dovecot-sieve=1:2.2.22-1ubuntu2 \
					   dovecot-lmtpd=1:2.2.22-1ubuntu2  \
					   dovecot-sieve=1:2.2.22-1ubuntu2 \
					   dovecot-mysql=1:2.2.22-1ubuntu2  \
					   dovecot-sieve=1:2.2.22-1ubuntu2  \
					   dovecot-gssapi=1:2.2.22-1ubuntu2 \
					   dovecot-ldap=1:2.2.22-1ubuntu2 &&\
	mkdir -p /var/mail &&\
	chown dovecot /var/mail &&\
	mkdir -p /var/run/dovecot &&\
	chown -R dovecot /var/run/dovecot/ &&\
	usermod -G containers -a dovecot &&\
 	/home/post_build_clean.sh
	
ADD dovecot/conf.d /etc/dovecot/conf.d
ADD dovecot/dovecot-sql.conf.ext /etc/dovecot/
ADD sudoers /etc/sudoers.d/dovecot
ADD home home

RUN chown dovecot /etc/dovecot/dovecot-sql.conf.ext &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER dovecot

ENV ContUser dovecot

CMD ["/home/start.sh"]