FROM  engines/passenger:$release
ENV ruby_version 2.2.2
RUN apt-get -y install telnet libcurl4-openssl-dev;\	
	 /usr/local/rbenv/bin/rbenv  install $ruby_version;\
	 /usr/local/rbenv/bin/rbenv  global $ruby_version
ADD home home
ENV RELEASE $release


ENV ContUser www-data
ENV ContGrp ruby





RUN /usr/local/rbenv/shims/gem install git bundle oink vmstat rest-client net_http_unix yajl-ruby ;\	
	chown -R www-data /home/app/ /var/log/apache2/;\
	mkdir -p  /run/apache2;\
	chown -R www-data /run/apache2 ;\
 	mkdir -p /run/lock/apache2 ;\
 	a2enmod ssl;\
 	chown www-data /run/lock/apache2;\
 	mkdir -p /home/app/public/system;\
 	chown -R www-data /home/app/public ;\
 	mkdir -p /usr/lib/src;\
 	cp -dpR /usr/share/passenger/ruby_extension_source /usr/lib/src/ruby_native_extension;\
 	passenger-config  build-native-support ;\
 	usermod -G containers -a www-data ;\
 	
 


WORKDIR /home/app/
RUN	git init

ADD gitconfig.tmpl /home/app/.git/config.tmpl
RUN cat /home/app/.git/config.tmpl  | sed "/\$release/s//$release/" > /home/app/.git/config

ADD setup.sh /home/
RUN /home/deployment.sh

#After after chmod so not rewritable

ADD 000-default.conf /etc/apache2/sites-enabled/
ADD SSL-default.conf /etc/apache2/sites-enabled/
ADD	passenger.conf  /etc/apache2/mods-enabled/
#ADD Procfile.sh /home/app/

ENV HOME /home/app
		
CMD ["/home/start.sh"]
USER www-data
