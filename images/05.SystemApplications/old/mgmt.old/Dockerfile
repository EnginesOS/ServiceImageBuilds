FROM  engines/passenger:$release
ENV ruby_version 2.2.2
RUN /usr/sbin/addgroup --gid 999 docker;\
	apt-get -y install telnet openssh-server libcurl4-openssl-dev;\
	echo "Y" | adduser -q --uid 21000 --gid 999 --home /home/engines --disabled-password engines;\
	 /usr/local/rbenv/bin/rbenv  install $ruby_version;\
	 /usr/local/rbenv/bin/rbenv  global $ruby_version
ADD home home
ADD profile /home/engines/.profile


ENV ContUser engines
ENV ContGrp ruby

#need to create as linking sqllite
RUN mkdir -p /home/app/db
RUN chown engines /home/app/db

WORKDIR /home/app/
RUN	git init

ADD gitconfig /home/app/.git/config
ADD sudoers /etc/
RUN /usr/local/rbenv/shims/gem install git bundle oink vmstat rest-client net_http_unix yajl-ruby ;\	
	mkdir -p /home/engines/.ssh/mgmt;\
	chown -R 21000 /home/app/ /home/engines /var/log/apache2/;\
	chmod -R g+w /usr/local/rbenv/versions/ ;chgrp -R docker /usr/local/rbenv/versions/;\
	chown -R 21000 /usr/local/rbenv/versions/$ruby_version/lib/ruby/gems/2.1.0/extensions;\
	mkdir -p  /run/apache2;\
	chown -R 21000 /run/apache2 ;\
 	mkdir -p /run/lock/apache2 ;\
 	a2enmod ssl;\
 	chown 21000 /run/lock/apache2;\
 	mkdir -p /home/app/public/system;\
 	chown -R 21000 /home/app/public /home/engines/scripts/configurators/saved;\
 	usermod -G containers -a engines;\
 	mkdir -p /usr/lib/src;\
 	cp -dpR /usr/share/passenger/ruby_extension_source /usr/lib/src/ruby_native_extension;\
 	passenger-config  build-native-support
 	
 
COPY functions.sh  /home/engines/scripts/functions.sh

#After after chmod so not rewritable

ADD 000-default.conf /etc/apache2/sites-enabled/
ADD SSL-default.conf /etc/apache2/sites-enabled/
ADD	passenger.conf  /etc/apache2/mods-enabled/
#ADD Procfile.sh /home/app/

ENV HOME /home/engines/
		
CMD ["/home/start.sh"]
USER 21000
