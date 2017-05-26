FROM  engines/servicebase:$release


RUN adduser -q --disabled-password  redis -uid 22029;\
	/home/no_init.sh ;\			
apt-get update -y;\
	apt-get -y install redis-server;\
	mkdir -p /var/lib/redis /var/run/redis/ ;\ 
	usermod -G containers -a redis 
	
COPY redis.conf /etc/redis/
COPY home home

RUN mkdir -p /home/consumers/saved/ /home/configurators/saved ;\
	chown www-data -R  /home/configurators/saved  /home/consumers/saved/

ENV ContUser redis
ENV ContGrp www-data

USER redis

CMD ["/home/start.sh"]