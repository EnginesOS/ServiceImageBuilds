FROM  enginees/servicebase:$release

RUN echo "Y" | adduser -q --disabled-password --home /var/spool/postfix -uid 22003 postfix&&\
	/home/no_init.sh &&\	
	echo "deb http://archive.canonical.com/ubuntu xenial partner" >> /etc/apt/sources.list &&\
	apt-get -y update &&\	
	apt-get -y install apache2 php-gettext php-mbstring libapache2-mod-php7.0 php-mysql php-mcrypt php-gd php-apcu php-dev postfix php-imap postfix-mysql postgrey 
	
ADD home home

RUN cd /tmp/ &&\
	 wget http://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-3.0/postfixadmin-3.0.tar.gz &&\
	 tar -xzpf postfixadmin-3.0.tar.gz &&\
	 mv  postfixadmin-3.0 /home/app &&\
	 mkdir -p /var/log/apache2 /etc/postfix/mysql &&\
	 chown www-data /var/log/apache2 &&\
	 ln -s /etc/php/7.0/mods-available/imap.ini /etc/php/7.0/apache2/conf.d/ &&\
	 chgrp www-data /home/app/templates_c/ &&\
	 chmod g+w /home/app/templates_c &&\
	 usermod -G containers -a postfix &&\
	 touch /etc/postfix/smarthost_passwd &&\
	 mkdir /usr/share/doc/postfix/html &&\
	 echo setpers &&\
	 /usr/sbin/postfix -c /etc/postfix/ set-permissions &&\
	 cp /etc/resolv.conf /var/spool/postfix/etc/ &&\
	 cp /etc/services /var/spool/postfix/etc/ &&\
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
ADD 000-default.conf /etc/apache2/sites-enabled/ 

RUN postmap /etc/postfix/transport &&\
    postmap  etc/postfix/smarthost_passwd &&\
	chown postfix /etc/postfix/smarthost_passwd* /home/configurators/saved/ /etc/postfix/mailname /etc/postfix/transport.db /etc/postfix/transport /home/app/config.inc.php /etc/postfix/mysql &&\
	mkdir -p /home/email /home/configurators/grey/ &&\
	chown postfix /home/email /home/configurators/saved/antispam/ /home/configurators/grey/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/postfix

ENV ContUser postfix
ENV ContGrp postfix

USER postfix

CMD ["/home/start.sh"]