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
	                   php-ldap \
	                   php-bcmath \
	                   php-dev  &&\
	 phpenmod ldap &&\
	 pear install Net_LDAP2 &&\
	 usermod -G containers -a openid &&\
 	/home/post_build_clean.sh

COPY home home
ADD sudoers /etc/sudoers.d/openid

RUN mkdir -p /home/consumers/saved/ &&\
	chown openid -R  /home/engines/scripts/configurators/saved  /home/consumers/saved/ &&\
	cd /tmp &&\
	 wget http://downloads.sourceforge.net/simpleid/simpleid-1.0.2.tar.gz &&\
	 tar -xzpf simpleid-1.0.2.tar.gz &&\
	 mv simpleid /home/simpleid &&\
	 wget https://raw.githubusercontent.com/simpleid/simpleid-ldap/master/ldap-filesystem.store.php &&\
	 mv ldap-filesystem.store.php /home/simpleid/www/ &&\
	 chmod -R go-rw /etc/sudoers /etc/sudoers.d/
	 
	 
COPY src/config.php /home/simpleid/www/
COPY src/ldap-filesystem.store.config.php /home/simpleid/www/
COPY src/apache2 /etc/apache2

ENV ContUser openid
ENV ContGrp openid

USER openid

CMD ["/home/start.sh"]