FROM engines/apache:$release
#FROM engines/frameworkbase:$release
ADD home home

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN /usr/sbin/usermod -u 22671 www-data &&\
	apt-get update -y &&\
	apt-get install -y  software-properties-common apt-file &&\
	echo " " | LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php &&\
	apt-get update -y &&\
	apt-get install -y  libapache2-mod-php5.6 \
			            php5.6-gettext \
			            php5.6-mbstring \
			            php5.6-mysql \
			            php5.6-mcrypt \
			            php5.6-gd \
			            php5.6-apcu \
			            php5.6-dev &&\
	apt-get remove  php7.0-common &&\
	chown www-data /var/www/ &&\
	usermod -G smmsp -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh &&\
	a2dismod php7.0 ;\
	a2enmod php5.6	


ADD src/30-sendmail.ini /etc/php/5.6/apache2/conf.d/


ENv PHP_VERSION	5.6