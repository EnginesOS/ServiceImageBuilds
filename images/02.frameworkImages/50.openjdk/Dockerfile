FROM engines/frameworkbase:$release

RUN apt-mark unhold tzdata ;\
	apt-get -y  --force-yes update;\
	apt-get -y  --force-yes upgrade;\
	/usr/sbin/usermod -u 22671 www-data;\
	apt-get install -y  --force-yes openjdk-7-jre-headless ;\
 	usermod -G containers -a www-data ;\
	apt-get clean ;\
		apt-get autoremove ;\
		apt-get autoclean ;\		
		rm -rf /tmp/*

ADD home home



ENV ContUser www-data
ENV ContGrp www-data