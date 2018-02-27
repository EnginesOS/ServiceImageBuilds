FROM engines/sinatra:$release

RUN /usr/sbin/usermod -u 22050 www-data &&\
	apt-get -y install libkrb5-dev memcachedb &&\
 	/home/post_build_clean.sh

ENV ContUser www-data
ENV ContGrp ruby

RUN gem install oink rest-client net_http_unix yajl-ruby rkerberos

ADD home home

RUN	chgrp containers /home &&\
    mkdir /home/app/ &&\
    mkdir /home/app/cache &&\
 	chmod -R ug+w /home/app/ &&\
 	chown -R www-data /home/app/ &&\
 	usermod -G containers -a www-data 
 	
USER www-data

RUN	echo -n master >/home/app/release;\
    /home/engines/scripts/startup/deploy.sh

ENV HOME /home/app
WORKDIR /home/app/
USER www-data
RUN	/home/engines/scripts/engine/deploy.sh

CMD ["/home/engines/scripts/startup/start.sh"]
