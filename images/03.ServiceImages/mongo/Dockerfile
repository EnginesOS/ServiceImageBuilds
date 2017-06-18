FROM  engines/servicebase:$release

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 ; echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' |  tee /etc/apt/sources.list.d/mongodb.list ;apt-get -y update &&\
    echo "Y" | adduser -q --disabled-password -uid 22008 mongo &&\
    apt-get -y update &&\
	/home/no_init.sh &&\	
    apt-get install -y mongodb-org &&\
	usermod -G containers -a mongo &&\
	mkdir -p /var/lib/mongodb &&\
	chown mongo /var/lib/mongodb &&\
 	/home/post_build_clean.sh
	
	
ADD home home
COPY mongod.conf /etc/
RUN chown mongo /home/configurators/saved ; chmod 700 /home/configurators/saved
ENV ContUser mongo
ENV ContGrp mongo
USER mongo
ENV ContUser mongo
CMD ["/home/start.sh"]