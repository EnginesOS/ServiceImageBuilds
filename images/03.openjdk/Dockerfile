FROM engines/frameworkbase:$release

RUN apt-get -y  --force-yes update;\
	apt-get -y  --force-yes upgrade;\
	/usr/sbin/usermod -u 22671 www-data;\
	apt-get install -y  --force-yes openjdk-7-jre-headless ;\
	apt-get clean ;\
 	usermod -G containers -a www-data

ADD home home



ENV ContUser www-data
ENV ContGrp www-data