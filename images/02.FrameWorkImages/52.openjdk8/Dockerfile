FROM engines/frameworkbase:$release

RUN apt-mark unhold tzdata ;\
	/usr/sbin/usermod -u 22671 www-data;\
	apt-get update -y ;\
	apt-get install -y  --force-yes openjdk-8-jdk-headless ;\
 	usermod -G containers -a www-data ;\
 	/home/post_build_clean.sh
 	
ADD home home

ENV ContUser www-data
ENV ContGrp www-data