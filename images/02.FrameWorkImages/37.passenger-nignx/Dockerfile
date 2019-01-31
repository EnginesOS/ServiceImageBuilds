FROM engines/rails5:$release

ENV RAILS_ENV production

RUN /usr/sbin/usermod -u 22671 www-data &&\
	apt-get install -y dirmngr gnupg &&\
 	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 &&\
 	apt-get update -y &&\
	apt-get install -y apt-transport-https  &&\
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main >/etc/apt/sources.list.d/passenger.list &&\ 
	chmod 600 /etc/apt/sources.list.d/passenger.list &&\
	apt-get update -y &&\
	apt-get install -y passenger-dev &&\
	gem install passenger &&\   
	apt-get install -y nginx-common \
						 libnginx-mod-http-passenger \
	                   nginx-extras \
	                   nginx &&\
 	mkdir -p /var/www/.passenger &&\
 	chown www-data /var/www/.passenger &&\
	usermod -G containers -a www-data &&\
 	chown www-data /var/lib/nginx/ &&\
 	passenger-config  build-native-support &&\
 	touch /home/.env_vars  &&\
 	chown www-data /home/.env_vars /var/run/
 	 
COPY src/etc/nginx/ /etc/nginx
COPY src/ruby_env /home/
ENV ContUser www-data
ENV ContGrp www-data

