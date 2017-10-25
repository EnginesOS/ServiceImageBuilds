FROM  engines/sinatra:$release

RUN /usr/sbin/usermod -u 22050 www-data &&\
	apt-get -y install libcurl4-openssl-dev &&\
 	/home/post_build_clean.sh

ENV ContUser www-data
ENV ContGrp ruby

RUN gem install oink rest-client net_http_unix yajl-ruby 
ADD home home

RUN	mkdir -p /home/app/data  &&\
 	mkdir -p /home/app/public  &&\
 	chown -R www-data /home/app &&\ 	
 	usermod -G containers -a www-data 
 	
USER www-data

WORKDIR /home/app/

RUN	git init

ENV RELEASE $release

ADD src/gitconfig.tmpl /home/app/.git/config.tmpl

RUN cat /home/app/.git/config.tmpl | sed "/\$release/s//$RELEASE/" > /home/app/.git/config &&\
	/home/deployment.sh

ENV HOME /home/app

USER www-data

CMD ["/home/start.sh"]

