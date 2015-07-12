FROM  engines/servicebase:$release
RUN echo "Y" | adduser -q --disabled-password --home /var/spool/postfix -uid 22003 postfix
RUN apt-get -y update;\
	apt-get -y install apache2 libapache2-mod-php5 php5-mysql php5-mcrypt  php5-gd php5-apcu php5-dev  postfix syslogd  php5-imap postfix-mysql postgrey;\
	apt-get clean
ADD home home

ADD postfix/main.cf /etc/postfix/
ADD postfix/master.cf /etc/postfix/
ADD postfix/mailname /etc/postfix/mailname

ADD postgrey /etc/default/postgrey
ADD sudoers /etc/
RUN cd /tmp/;\
	 wget http://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-2.92/postfixadmin-2.92.tar.gz;\
	 tar -xzpf postfixadmin-2.92.tar.gz;\
	 mv  postfixadmin-2.92 /home/app ;\
	 mkdir -p /var/log/apache2 /etc/postfix/mysql;\
	 chown www-data /var/log/apache2 ;\
	 ln -s /etc/php5/mods-available/imap.ini /etc/php5/apache2/conf.d/;\
	 chgrp www-data /home/app/templates_c/;\
	 chmod g+w /home/app/templates_c;\
	 usermod -G containers -a postfix
	 
	 

ADD _config.inc.php  /home/app/
ADD config.inc.php  /home/app/
RUN chown postfix /home/app/config.inc.php /etc/postfix/mysql
ADD 000-default.conf /etc/apache2/sites-enabled/ 
	
	

ENV ContUser postfix
ENV ContGrp postfix
USER postfix
CMD ["/home/init.sh"]