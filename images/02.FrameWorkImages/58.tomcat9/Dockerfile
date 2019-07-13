FROM engines/openjdk11:$release

ADD home home
RUN  apt-mark unhold tzdata &&\
	/usr/sbin/usermod -u 22671 www-data &&\
	apt-get update -y &&\
	cat /etc/apt/sources.list &&\
	apt-get install -y tomcat9 &&\
	ln -s /var/log/tomcat9 /usr/share/tomcat9/logs &&\
 	ln -s /etc/tomcat9 /usr/share/tomcat9/conf &&\
 	ln -s /tmp /usr/share/tomcat9/temp &&\
 	usermod -G containers -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh


ADD home home
ADD home/webapps/ /usr/share/tomcat9/webapps

ENV ContUser www-data
ENV ContGrp www-data