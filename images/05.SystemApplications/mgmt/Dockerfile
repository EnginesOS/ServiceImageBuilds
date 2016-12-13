FROM  engines/ngpassenger:$release
ENV ruby_version 2.3.0
RUN 	 /usr/sbin/usermod -u 22050 www-data;\
		apt-get -y install libcurl4-openssl-dev;\
 		/home/post_build_clean.sh




ENV ContUser www-data
ENV ContGrp ruby

RUN gem   install   oink rest-client net_http_unix yajl-ruby ;\	
	mkdir -p /usr/lib/src;\
 	cp -dpR /usr/share/passenger/ruby_extension_source /usr/lib/src/ruby_native_extension 	
 	#passenger-config  build-native-support
 	
ADD home home

RUN	mkdir -p /home/app;\
 	mkdir -p /home/app/public/system;\
 	chown -R www-data /home/app/;\ 	
 	usermod -G containers -a www-data 
 	
 
#
#
#
#
#wget https://s3.amazonaws.com/jruby.org/downloads/9.1.6.0/jruby-bin-9.1.6.0.tar.gz
#tar -xzpf jruby-bin-9.1.6.0.tar.gz
# mv /tmp/jruby-9.1.6.0 /opt
# update-alternatives --install /usr/bin/jruby ruby /opt/jruby-9.1.6.0/bin/jruby 100
# jgem install bundle
#ln -s  /usr/include/ruby-2.3.0/ruby/ruby.h /opt/jruby-9.1.6.0/lib/ruby/include/ruby/ 


USER www-data
WORKDIR /home/app/
RUN	git init
ENV RELEASE $release
ADD gitconfig.tmpl /home/app/.git/config.tmpl
RUN cat /home/app/.git/config.tmpl  | sed "/\$release/s//$release/" > /home/app/.git/config


RUN /home/deployment.sh

ADD profile /var/www/.profile

ENV HOME /home/app

COPY etc/nginx/ /etc/nginx
COPY ruby_env /home/app/.ruby_env
USER 0
COPY passenger.conf /etc/nginx/
RUN chmod ugo+w -R /etc/nginx/sites-enabled/default /etc/nginx/;\
	mkdir -p /var/run/nginx/ /var/lib/nginx /var/log/nginx;\
	chown www-data /var/run/ /var/lib/nginx /var/run/nginx/ /var/log/nginx/
	
USER www-data
CMD ["/home/start.sh"]

