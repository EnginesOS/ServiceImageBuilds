FROM  engines/servicebase:$release


RUN usermod www-data -u 22005;\
	apt-get -y update;\
	apt-get -y install nginx;\
	apt-get clean;\
	mkdir -p /var/lib/nginx /var/run/nginx/ ;\ 
	chown www-data /var/lib/nginx /var/run/nginx/ /etc/nginx/sites-enabled;\
	usermod -G containers -a www-data 
	

COPY home home

COPY etc/nginx/ /etc/nginx
RUN chown www-data -R /etc/nginx/sites-enabled

ENV ContUser www-data
ENV ContGrp www-data

USER 22005

CMD ["/home/init.sh"]