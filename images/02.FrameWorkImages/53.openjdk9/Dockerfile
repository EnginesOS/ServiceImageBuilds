FROM engines/frameworkbase:$release
ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk-amd64
ADD home home
RUN apt-mark unhold tzdata &&\
	/usr/sbin/usermod -u 22671 www-data &&\
	apt-get update -y &&\
	apt-get install -y openjdk-9-jre-headless &&\
 	usermod -G containers -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh
 	
ADD home home
ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk-amd64/

ENV ContUser www-data
ENV ContGrp www-data