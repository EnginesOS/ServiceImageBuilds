FROM engines/ruby2.x
#engines/servicebase:$release

RUN 	 /usr/sbin/usermod -u 22050 www-data;\
		apt-get -y install libcurl4-openssl-dev ruby-dev

ENV ContUser www-data
ENV ContGrp ruby

#RUN /usr/local/rbenv/shims/gem install  --no-rdoc --no-ri  bundle 
 	
ADD home home

RUN	mkdir -p /home/app;\
 	mkdir -p /home/app/public/system;\
 	chown -R www-data /home/app/;\ 	
 	gem install bundle;\ 	
 	usermod -G containers -a www-data 

USER www-data
WORKDIR /home/app/
RUN	git init
ENV RELEASE $release
ADD gitconfig.tmpl /home/app/.git/config.tmpl

RUN cat /home/app/.git/config.tmpl  | sed "/\$release/s//$release/" > /home/app/.git/config


RUN /home/deployment.sh

ADD config.ru /home/app

ENV HOME /home/app

CMD ["/home/start.sh"]

