FROM  engines/ngpassenger:$release
ENV ruby_version 2.2.2
RUN apt-get -y install libcurl4-openssl-dev;\
	 /usr/sbin/usermod -u 22050 www-data;\
	 /usr/local/rbenv/bin/rbenv  install $ruby_version;\
	 /usr/local/rbenv/bin/rbenv  global $ruby_version




ENV ContUser www-data
ENV ContGrp ruby

RUN /usr/local/rbenv/shims/gem install  bundle oink rest-client net_http_unix yajl-ruby ;\	
	mkdir -p /usr/lib/src;\
 	cp -dpR /usr/share/passenger/ruby_extension_source /usr/lib/src/ruby_native_extension;\ 	
 	passenger-config  build-native-support
 	
ADD home home

RUN	mkdir -p /home/app;\
 	mkdir -p /home/app/public/system;\
 	chown -R www-data /home/app/;\ 	
 	usermod -G containers -a www-data 
 	
 


USER www-data
WORKDIR /home/app/
RUN	git init
ENV RELEASE $release
ADD gitconfig.tmpl /home/app/.git/config.tmpl
RUN cat /home/app/.git/config.tmpl  | sed "/\$release/s//$release/" > /home/app/.git/config


RUN /home/deployment.sh

ADD profile ~www-data/.profile

ENV HOME /home/app
		
CMD ["/home/start.sh"]

