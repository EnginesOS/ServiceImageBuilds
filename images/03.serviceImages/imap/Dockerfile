From engines/servicebase:$release



RUN adduser -q --disabled-password  -uid 22013 dovecot;\
 	apt-get -y  update;\
 	 rm /usr/sbin/invoke-rc.d;\
        ln -s /bin/true /usr/sbin/invoke-rc.d;\ 	
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

CMD ["/home/init.sh"]