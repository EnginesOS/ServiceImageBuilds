FROM  engines/ngpassenger:$release

RUN /usr/sbin/usermod -u 22050 www-data &&\
	apt-get -y install libsqlite3-dev \
					   libcurl4-openssl-dev &&\
 	/home/engines/scripts/build/post_build_clean.sh

ENV ContUser www-data
ENV ContGrp ruby

RUN gem install sqlite3  oink rest-client net_http_unix yajl-ruby &&\	
	mkdir -p /usr/lib/src &&\
 	cp -dpR /usr/share/passenger/ruby_extension_source /usr/lib/src/ruby_native_extension 	
 	
ADD home home

RUN	mkdir -p /home/app &&\
 	mkdir -p /home/app/public/system &&\
 	chown -R www-data /home/app/ &&\ 	
 	usermod -G containers -a www-data 
 	
USER www-data

WORKDIR /home/app/

RUN	git init

ENV RELEASE $release

ADD src/gitconfig.tmpl /home/app/.git/config.tmpl

RUN cat /home/app/.git/config.tmpl | sed "/\$release/s//$RELEASE/" > /home/app/.git/config &&\
	/home/engines/scripts/engine/deployment.sh

ADD src/profile /var/www/.profile

ENV HOME /home/app

COPY src/etc/nginx/ /etc/nginx
COPY src/ruby_env /home/app/.ruby_env

USER 0

COPY src/passenger.conf /etc/nginx/

RUN chmod ugo+w -R /etc/nginx/sites-enabled/default /etc/nginx/ &&\
	mkdir -p /var/run/nginx/ /var/lib/nginx &&\
	chown www-data /var/run/ /var/lib/nginx /var/run/nginx/ 

ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin

USER www-data

CMD ["/home/start.sh"]

