FROM engines/servicebase:$release

RUN   apt-get -y update;\
	apt-get upgrade -y;\
	/home/no_init.sh 
	apt-get install -y apache2 libapache2-mod-php5 php5-mysql php5-mcrypt  php5-gd php5-apcu php5-dev
	
RUN	mkdir /home/app;
		git clone https://github.com/potsky/PimpMyLog.git
	 
ADD 000-default.conf /etc/apache2/sites-enabled/ 
		
ENV ContUser www-data
ENV ContGrp www-data
USER www-data
CMD ["/home/start.sh"]	
