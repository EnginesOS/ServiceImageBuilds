FROM  engines/servicebase:$release

RUN adduser -q --disabled-password  redis -uid 22029 &&\
	/home/no_init.sh &&\			
	apt-get update -y &&\
	apt-get -y install redis-server &&\
	mkdir -p /var/lib/redis /var/run/redis/ &&\ 
	usermod -G containers -a redis 
	
COPY src/redis.conf /etc/redis/
COPY home home

RUN mkdir -p /home/consumers/saved/ /home/engines/scripts/configurators/saved /home/redis &&\
	chown redis -R  /home/redis /home/engines/scripts/configurators/saved /home/consumers/saved/ 
	
ENV ContUser redis
ENV ContGrp www-data

USER redis

CMD ["/home/engines/scripts/system/start.sh"]