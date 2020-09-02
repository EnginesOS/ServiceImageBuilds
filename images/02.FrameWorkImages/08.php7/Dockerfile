FROM engines/apache:$release
#FROM engines/frameworkbase:$release


ADD home home

RUN /usr/sbin/usermod -u 22671 www-data &&\
	apt-get update -y &&\
	apt-get install -y libapache2-mod-php \
					   php-mbstring \
					   php-mysql \
					   php-gd \
					   php-apcu \
					   php-dev \
					   php-pear \
					   re2c &&\
	chown www-data /var/www/ &&\
	usermod -G smmsp -a www-data &&\
	pecl channel-update pecl.php.net &&\
	mkdir /tmp/composer &&\
	cd /tmp/composer &&\
	curl -sS https://getcomposer.org/installer | php &&\
	mv composer.phar  /usr/local/bin &&\
 	/home/engines/scripts/build/post_build_clean.sh
	
ENV PHP_VERSION	7.4

