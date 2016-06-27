From engines/servicebase:$release



RUN adduser -q --disabled-password  -uid 22013 dovecot;\
	adduser -q --disabled-password  -uid 22014 vmail;\
 	apt-get -y  update;\
	apt-get upgrade -y;\
	/home/no_init.sh ;\		
	apt-get -y install syslogd  dovecot-core dovecot-imapd  dovecot-pop3d  dovecot-sieve dovecot-lmtpd dovecot-mysql ;\
	apt-get clean ;\
	mkdir -p /var/mail ;\
	chown dovecot /var/mail ;\
	mkdir -p /var/run/dovecot;\
	chown -R dovecot /var/run/dovecot/;\
	usermod -G containers -a dovecot 
	
ADD dovecot/conf.d /etc/dovecot/conf.d

ADD dovecot/dovecot-sql.conf.ext /etc/dovecot/
run chown dovecot /etc/dovecot/dovecot-sql.conf.ext
ADD sudoers /etc/sudoers
ADD home home
USER dovecot
ENV ContUser dovecot
CMD ["/home/start.sh"]