From engines/servicebase:$release



RUN adduser -q --disabled-password  -uid 22013 dovecot;\
	adduser -q --disabled-password  -uid 22014 vmail;\
	/home/no_init.sh ;\	
	apt-get -y  update;\	
	apt-get -y install  inetutils-syslogd   dovecot-core dovecot-imapd  dovecot-pop3d  dovecot-sieve dovecot-lmtpd dovecot-mysql ;\
	mkdir -p /var/mail ;\
	chown dovecot /var/mail ;\
	mkdir -p /var/run/dovecot;\
	chown -R dovecot /var/run/dovecot/;\
	usermod -G containers -a dovecot ;\
 	/home/post_build_clean.sh
	
ADD dovecot/conf.d /etc/dovecot/conf.d

ADD dovecot/dovecot-sql.conf.ext /etc/dovecot/
run chown dovecot /etc/dovecot/dovecot-sql.conf.ext
ADD sudoers /etc/sudoers.d/dovecot
ADD home home
USER dovecot
ENV ContUser dovecot
CMD ["/home/start.sh"]