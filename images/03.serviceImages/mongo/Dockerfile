FROM  engines/servicebase:$release

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 ; echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' |  tee /etc/apt/sources.list.d/mongodb.list ;apt-get update;\
    echo "Y" | adduser -q --disabled-password -uid 22008 mongo;\
    apt-get -y update;\
    apt-get install -y mongodb-org;\
	apt-get clean;\
	usermod -G containers -a mongo;\
	mkdir -p /var/lib/mongodb;\
	chown mongo /var/lib/mongodb
	
ADD home home

ENV ContUser mongo
ENV ContGrp mongo
USER mongo
CMD ["/home/init.sh"]