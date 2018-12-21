FROM  engines/servicebase:$release

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 ; echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' |  tee /etc/apt/sources.list.d/mongodb.list &&\
    useradd -u 22008  -g mongo -d /home/mongo -m -G containers mongo
    apt-get -y update &&\
	/home/engines/scripts/build/no_init.sh &&\	
    apt-get install -y mongodb-org &&\
	mkdir -p /var/lib/mongodb &&\
	chown mongo /var/lib/mongodb &&\
 	/home/engines/scripts/build/post_build_clean.sh
	
ADD home home

COPY src/mongod.conf /etc/

RUN chown mongo /home/engines/scripts/configurators/saved ; chmod 700 /home/engines/scripts/configurators/saved

ENV ContUser mongo
ENV ContGrp mongo

USER mongo

CMD ["/home/engines/scripts/system/start.sh"]