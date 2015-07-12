FROM engines/frameworkbase:$release

RUN /usr/sbin/usermod -u 22671 www-data;\
	apt-get update -y;\
	apt-get install -y  apache2 libapache2-mod-php5 php5-mysql php5-mcrypt  php5-gd php5-apcu php5-dev php-pear;\
	apt-get clean ;\
	rm etc/apache2/sites-enabled/*;\
	mkdir -p /etc/apache2/ /var/run/apache2/lock/;\
	chown www-data -R /var/run/apache2	;\
	chown www-data /var/www/;\
	usermod -G containers -a www-data
	
ENV APACHE_LOCK_DIR /var/run/apache2/lock/
	#now in framework
	#echo "www-data ALL=(data-user) NOPASSWD: /home/engines/scripts/_revoke_rw_access.sh" >> /etc/sudoers;\
	#echo "www-data ALL=(data-user) NOPASSWD: /home/engines/scripts/_grant_rw_access.sh " >> /etc/sudoers
	
ADD home home
ADD 30-sendmail.ini /etc/php5/apache2/conf.d/
ADD 000-default.conf /etc/apache2/sites-enabled/
ADD ports.conf /etc/apache2/

ENV ContUser www-data
ENV ContGrp www-data