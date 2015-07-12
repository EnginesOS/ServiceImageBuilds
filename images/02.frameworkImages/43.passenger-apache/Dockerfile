FROM engines/rails4:$release

ENV RAILS_ENV production

RUN /usr/sbin/usermod -u 22671 www-data ;\
	apt-get -y update;\
 	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 ;\
	apt-get install -y apt-transport-https ca-certificates apache2 apache2-mpm-worker apache2-threaded-dev libapr1-dev libaprutil1-dev ;\
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main  >/etc/apt/sources.list.d/passenger.list;\ 
	chmod 600 /etc/apt/sources.list.d/passenger.list;\
	apt-get update -y ;\
	apt-get install -y    libapache2-mod-passenger passenger-dev ;\
	a2enmod passenger;\
	apt-get clean ;\
    rm etc/apache2/sites-enabled/*;\
	/usr/local/rbenv/shims/gem install passenger;\
    /usr/local/rbenv/shims/passenger-install-apache2-module -a --languages ruby,nodejs,python;\
	mkdir -p /var/log/apache2 ;\
	chown -R www-data /var/log/apache2 ;\
	a2enmod rewrite; \
 	mkdir -p /lock/apache2 ;\
 	chown www-data /run/lock/apache2;\
 	mkdir   -p /var/www/.passenger ;\
 	chown www-data /var/www/.passenger ;\
 	usermod -G containers -a www-data
 	
ADD 000-default.conf /etc/apache2/sites-enabled/
ADD	passenger.conf  /etc/apache2/mods-enabled/
ADD ports.conf /etc/apache2/

ENV ContUser www-data
ENV ContGrp www-data

