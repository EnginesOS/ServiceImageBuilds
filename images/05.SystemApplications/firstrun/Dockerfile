FROM engines/ruby2.x:$release

RUN  /usr/sbin/usermod -u 22050 www-data &&\
	apt-get -y update &&\
	apt-get -y install libcurl4-openssl-dev\
					   ruby-dev

ENV ContUser www-data
ENV ContGrp ruby
 	
ADD home home

RUN	mkdir -p /home/app &&\
 	mkdir -p /home/app/public/system &&\
 	chown -R www-data /home/app/ &&\ 	
 	gem install bundle bundler &&\ 	
 	usermod -G containers -a www-data 

USER www-data

WORKDIR /home/app/

RUN	git init

ENV RELEASE $release
ADD src/gitconfig.tmpl /home/app/.git/config.tmpl

RUN cat /home/app/.git/config.tmpl | sed "/\$release/s//$release/" > /home/app/.git/config &&\
	/home/engines/scripts/engine/deployment.sh

ADD src/config.ru /home/app

ENV HOME /home/app

CMD ["/home/engines/scripts/startup/start.sh"]
