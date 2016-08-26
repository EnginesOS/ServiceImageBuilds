FROM  engines/servicebase:$release
RUN echo "Y" | adduser -q --disabled-password --home /var/spool/postfix -uid 22003 postfix
RUN /home/no_init.sh ;\	
	apt-get -y install apache2 libapache2-mod-php5 php5-mysql php5-mcrypt  php5-gd php5-apcu php5-dev  postfix syslogd  php5-imap postfix-mysql postgrey;\
	
ADD home home




RUN cd /tmp/;\
	 wget http://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-2.92/postfixadmin-2.92.tar.gz;\
	 tar -xzpf postfixadmin-2.92.tar.gz;\
	 mv  postfixadmin-2.92 /home/app ;\
	 mkdir -p /var/log/apache2 /etc/postfix/mysql;\
	 chown www-data /var/log/apache2 ;\
	 ln -s /etc/php5/mods-available/imap.ini /etc/php5/apache2/conf.d/;\
	 chgrp www-data /home/app/templates_c/;\
	 chmod g+w /home/app/templates_c;\
	 usermod -G containers -a postfix;\
	 touch  /etc/postfix/smarthost_passwd;\
	 /usr/sbin/postfix -c /etc/postfix/ set-permissions;\
	 cp /etc/resolv.conf /var/spool/postfix/etc/;\
	 cp /etc/services /var/spool/postfix/etc/;\
 	/home/post_build_clean.sh
	
ADD postgrey /etc/default/postgrey
ADD sudoers /etc/sudoers.d/postfix	 
ADD postfix/main.cf /etc/postfix/
ADD postfix/master.cf /etc/postfix/
ADD postfix/mailname /etc/postfix/mailname
ADD postfix/transport /etc/postfix/transport
ADD _config.inc.php  /home/app/
ADD config.inc.php  /home/app/
ADD htaccess /home/app/.htaccess
RUN postmap /etc/postfix/transport;\
     postmap  etc/postfix/smarthost_passwd;\
	chown postfix /etc/postfix/smarthost_passwd* /home/configurators/saved/ /etc/postfix/mailname /etc/postfix/transport.db /etc/postfix/transport /home/app/config.inc.php /etc/postfix/mysql
ADD 000-default.conf /etc/apache2/sites-enabled/ 
	
RUN mkdir -p /home/email /home/configurators/grey/; chown postfix /home/email /home/configurators/saved/antispam/ /home/configurators/grey/
	

ENV ContUser postfix
ENV ContGrp postfix
USER postfix
CMD ["/home/start.sh"]