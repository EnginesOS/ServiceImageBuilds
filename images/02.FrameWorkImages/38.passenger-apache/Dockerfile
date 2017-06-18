FROM engines/rails4:$release

ENV RAILS_ENV production

RUN /usr/sbin/usermod -u 22671 www-data &&\
	apt-get update -y &&\
 	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 &&\
	apt-get install -y apt-transport-https ca-certificates apache2 libapr1-dev libaprutil1-dev &&\
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main >/etc/apt/sources.list.d/passenger.list &&\ 
	chmod 600 /etc/apt/sources.list.d/passenger.list &&\
    rm etc/apache2/sites-enabled/* &&\
	gem install --no-rdoc --no-ri passenger &&\
    passenger-install-apache2-module -a --languages ruby,nodejs,python &&\
	a2enmod passenger &&\
	mkdir -p /var/log/apache2 &&\
	chown -R www-data /var/log/apache2 &&\
	a2enmod rewrite &&\
 	mkdir -p /lock/apache2 &&\
 	chown www-data /run/lock/apache2 &&\
 	mkdir -p /var/www/.passenger &&\
 	chown www-data /var/www/.passenger &&\
 	usermod -G containers -a www-data &&\
 	passenger-config  build-native-support &&\
 	/home/post_build_clean.sh

ADD 000-default.conf /etc/apache2/sites-enabled/
ADD	passenger.conf  /etc/apache2/mods-enabled/
ADD ports.conf /etc/apache2/

ENV ContUser www-data
ENV ContGrp www-data

