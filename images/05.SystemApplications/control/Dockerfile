FROM engines/sinatra:$release

USER 0

RUN /usr/sbin/usermod -u 22050 www-data &&\
     ls -la  /var/lib/dpkg/lock-frontend &&\
	apt-get -y install libkrb5-dev memcachedb haproxy &&\
 	/home/engines/scripts/build/post_build_clean.sh


ENV ContUser www-data
ENV ContGrp ruby

RUN gem install oink rest-client net_http_unix yajl-ruby rainbows

ADD home home

RUN	chgrp containers /home &&\
    mkdir /home/app/ &&\
    mkdir -p /home/app/cache /run/haproxy/ /var/lib/haproxy &&\
 	chmod -R ug+w /home/app/ &&\
 	usermod -G containers -a www-data &&\
 	chown www-data /run/haproxy/ /var/lib/haproxy 
 	

RUN	echo -n master >/home/app/release
COPY src/ /
RUN chown -R www-data /home/app/ ; ls -la /home/app
ENV HOME /home/app
WORKDIR /home/app/
USER www-data
ENV RACK_ENV production
RUN	/home/engines/scripts/engine/deploy.sh

CMD ["/home/engines/scripts/startup/start.sh"]
