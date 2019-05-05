FROM engines/frameworkbase:$release

ADD home home
RUN apt-mark unhold tzdata &&\
	/usr/sbin/usermod -u 22671 www-data &&\
	apt-get update -y &&\
	apt-get install -y openjdk-8-jre-headless &&\
 	usermod -G containers -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh
 	
ADD home home

ENV ContUser www-data
ENV ContGrp www-data