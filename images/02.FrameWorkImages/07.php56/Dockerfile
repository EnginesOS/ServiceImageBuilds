FROM engines/frameworkbase:$release
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN /usr/sbin/usermod -u 22671 www-data &&\
	apt-get update -y &&\
	apt-get install -y  python-software-properties software-properties-common apt-file &&\
	LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php &&\
	apt-get update -y &&\
	apt-get install -y  apache2 libapache2-mod-php5.6 php5.6-gettext php5.6-mbstring php5.6-mysql php5.6-mcrypt  php5.6-gd php5.6-apcu php5.6-dev &&\
	apt-get remove  php7.0-common &&\
	rm etc/apache2/sites-enabled/* &&\
	mkdir -p /etc/apache2/ /var/run/apache2/lock /var/run/apache2 &&\
	chown www-data -R /var/run/apache2 &&\
	chown www-data /var/www/ &&\
	usermod -G containers -a www-data &&\
	usermod -G smmsp -a www-data &&\
 	/home/post_build_clean.sh &&\
	a2dismod php7.0 &&\
	a2enmod php5.6
ENV APACHE_LOCK_DIR /var/run/apache2/lock/
	
	
ADD home home
ADD 30-sendmail.ini /etc/php/5.6/apache2/conf.d/
ADD 000-default.conf /etc/apache2/sites-enabled/
ADD ports.conf /etc/apache2/

ENV ContUser www-data
ENV ContGrp www-data
ENv PHP_VERSION	5.6