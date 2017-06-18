FROM engines/frameworkbase:$release

RUN apt-mark unhold tzdata &&\
	/usr/sbin/usermod -u 22671 www-data &&\
	add-apt-repository ppa:openjdk-r/ppa &&\
	apt-get update -y &&\
	apt-get install -y openjdk-7-jre-headless &&\
 	usermod -G containers -a www-data &&\
 	/home/post_build_clean.sh
 	
ADD home home



ENV ContUser www-data
ENV ContGrp www-data