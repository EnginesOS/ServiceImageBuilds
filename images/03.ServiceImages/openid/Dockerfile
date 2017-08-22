FROM  engines/servicebase:$release

RUN adduser -q --disabled-password --home /home/auth -uid 22032 openid &&\
	/home/no_init.sh &&\			
	apt-get update -y &&\
	apt-get -y install apache2 \
	                   php-gettext \
	                   php-mbstring \
	                   libapache2-mod-php7.0 \
	                   php-mcrypt \
	                   php-gd \
	                   php-apcu \
	                   php-dev  &&\
	usermod -G containers -a openid &&\
 	/home/post_build_clean.sh

COPY home home


RUN mkdir -p /home/consumers/saved/ &&\
	chown openid -R  /home/configurators/saved  /home/consumers/saved/ &&\
	cd /tmp &&\
	 wget http://downloads.sourceforge.net/simpleid/simpleid-1.0.2.tar.gz &&\
	 tar -xzpf simpleid-1.0.2.tar.gz &&\
	 mv simpleid /home/simpleid &&\
	 
COPY config.php /home/simpleid/www/
COPY apache2 /etc/apache2

ENV ContUser openid
ENV ContGrp openid

USER openid

CMD ["/home/start.sh"]