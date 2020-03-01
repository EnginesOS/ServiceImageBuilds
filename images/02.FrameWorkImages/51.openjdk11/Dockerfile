FROM engines/frameworkbase:$release
ENV OPENJDK_VERSION 11
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ADD home home
RUN apt-mark unhold tzdata &&\
	/usr/sbin/usermod -u 22671 www-data &&\
	add-apt-repository -y ppa:openjdk-r/ppa &&\
	apt-get update -y &&\
	apt-get install -y openjdk-${OPENJDK_VERSION}-jre-headless &&\
 	usermod -G containers -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh
 	
ADD home home

ENV ContUser www-data
ENV ContGrp www-data