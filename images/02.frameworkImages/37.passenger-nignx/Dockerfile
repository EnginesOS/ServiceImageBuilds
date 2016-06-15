FROM engines/rails4:$release

ENV RAILS_ENV production

RUN /usr/sbin/usermod -u 22671 www-data ;\
	apt-get -y update;\
	apt-get upgrade -y;\
 	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 ;\
	apt-get install -y apt-transport-https ca-certificates nginx ;\
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main  >/etc/apt/sources.list.d/passenger.list;\ 
	chmod 600 /etc/apt/sources.list.d/passenger.list;\
	apt-get update -y ;\
	apt-get install -y   nginx-extras  passenger-dev ;\
	apt-get clean ;\    
	/usr/local/rbenv/shims/gem install passenger;\   
 	mkdir   -p /var/www/.passenger ;\
 	chown www-data /var/www/.passenger ;\
 	usermod -G containers -a www-data ;\
 	passenger-config  build-native-support
 	
 

ENV ContUser www-data
ENV ContGrp www-data

