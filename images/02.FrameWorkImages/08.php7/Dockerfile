FROM engines/frameworkbase:$release
ADD sources.list /etc/apt/
RUN /usr/sbin/usermod -u 22671 www-data &&\
	apt-get update -y &&\
	apt-get install -y  apache2 libapache2-mod-php php-gettext php-mbstring php-mysql php-mcrypt  php-gd php-apcu php-dev php-pear re2c &&\
	rm etc/apache2/sites-enabled/* &&\
	mkdir -p /etc/apache2/ /var/run/apache2/lock/ &&\
	chown www-data -R /var/run/apache2 &&\
	chown www-data /var/www/ &&\
	usermod -G containers -a www-data &&\
	usermod -G smmsp -a www-data &&\
 	/home/post_build_clean.sh
	
ENV APACHE_LOCK_DIR /var/run/apache2/lock/
	
	
ADD home home
ADD 30-sendmail.ini /etc/php/7.0/apache2/conf.d/
ADD 000-default.conf /etc/apache2/sites-enabled/
ADD ports.conf /etc/apache2/

ENV ContUser www-data
ENV ContGrp www-data
ENv PHP_VERSION	7.0