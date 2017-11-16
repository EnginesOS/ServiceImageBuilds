FROM  engines/servicebase:$release

RUN usermod www-data -u 22005 &&\
	/home/no_init.sh &&\			
	apt-get update -y &&\
	apt-get -y install nginx &&\
	mkdir -p /var/lib/nginx /var/run/nginx/ &&\ 
	chown www-data /var/lib/nginx /var/run/nginx/ /etc/nginx/sites-enabled &&\
	usermod -G containers -a www-data &&\
 	/home/post_build_clean.sh

COPY home home
COPY src/html /usr/share/nginx/
COPY src/etc/nginx/ /etc/nginx

RUN mkdir -p /home/consumers/saved/ &&\
	chown www-data -R /etc/nginx/sites-enabled /home/engines/scripts/configurators/saved  /home/consumers/saved/

ENV ContUser www-data
ENV ContGrp www-data

USER 22005

CMD ["/home/start.sh"]