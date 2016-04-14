FROM engines/servicebase:$release

RUN  usermod -u 22027 www-data;\ 
	 usermod -G containers -a www-data;\
	apt-get -y update;\
	apt-get upgrade -y;\
	/home/no_init.sh ;\
	apt-get install -y apache2 libapache2-mod-php5 php5-mysql php5-mcrypt  php5-gd php5-apcu php5-dev
	
ADD home home
RUN	git clone https://github.com/potsky/PimpMyLog.git ;\
	mv /PimpMyLog /home/app 
	
ADD  config.user.php /home/app/
	
RUN mkdir /home/saved ;\
	chown 22027 /home/saved /home/app/config.user.php;\
	usermod -G utmp -a www-data;\
	usermod -G syslog -a www-data;\
	usermod -G adm -a www-data
	
ENV APACHE_LOCK_DIR /var/run/apache2/lock/
	ADD 000-default.conf /etc/apache2/sites-enabled/
ADD ports.conf /etc/apache2/	
ADD apache_envvars /etc/apache2/envvars	
ENV ContUser www-data
ENV ContGrp www-data
USER www-data
CMD ["/home/start.sh"]	
