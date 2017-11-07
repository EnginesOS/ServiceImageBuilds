FROM  engines/sinatra:$release

RUN /usr/sbin/usermod -u 22050 www-data &&\
	apt-get -y install libcurl4-openssl-dev &&\
 	/home/post_build_clean.sh

ENV ContUser www-data
ENV ContGrp ruby

RUN gem install oink rest-client net_http_unix yajl-ruby 
ADD home home

RUN	chgrp containers /home &&\
 	chmod g+w /home &&\
 	usermod -G containers -a www-data 
 	
USER www-data

RUN	/home/engines/scripts/engine/deploy.sh

USER 0
RUN	chown -R www-data /home/app &&\ 	
 	mkdir -p /home/app/data  &&\
 	mkdir -p /home/app/public  &&\
 	chmod g-w /home 

ENV HOME /home/app
WORKDIR /home/app/
USER www-data

CMD ["/home/start.sh"]

