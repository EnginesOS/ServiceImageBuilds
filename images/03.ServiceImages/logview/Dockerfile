FROM engines/servicebase:$release

RUN usermod -u 22027 www-data &&\ 
	usermod -G containers -a www-data &&\
	/home/no_init.sh &&\
	apt-get  update &&\
	apt-get install -y apache2 \
					   libapache2-mod-php \
					   php-gettext \
					   php-mbstring \
					   php-mysql \
					   php-mcrypt \
					   php-gd \
					   php-apcu \
					   php-dev &&\
 	/home/post_build_clean.sh
	
ADD home home

RUN	git clone https://github.com/potsky/PimpMyLog.git &&\
	mv /PimpMyLog /home/app 
	
ADD src/config.user.php /home/app/
	
RUN mkdir /home/saved /home/app/config.user.d/ &&\
	chown 22027 /home/saved /home/app/config.user.php /home/app/config.user.d/ &&\
	usermod -G utmp -a www-data &&\
	usermod -G syslog -a www-data &&\
	usermod -G adm -a www-data
	
ENV APACHE_LOCK_DIR /var/run/apache2/lock/
ENV ContUser www-data
ENV ContGrp www-data

ADD src/000-default.conf /etc/apache2/sites-enabled/
ADD src/ports.conf /etc/apache2/	
ADD src/apache_envvars /etc/apache2/envvars	

USER www-data

CMD ["/home/engines/scripts/system/start.sh"]	
