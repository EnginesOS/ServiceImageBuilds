FROM engines/openjdk9:$release

RUN  apt-mark unhold tzdata ;\
	/usr/sbin/usermod -u 22671 www-data;\
	apt-get update -y ;\
	apt-get install -y tomcat9 ;\
	ln -s /var/log/tomcat9 /usr/share/tomcat9/logs;\
 	ln -s  /etc/tomcat9  /usr/share/tomcat9/conf;\
 	ln -s /tmp /usr/share/tomcat9/temp ;\
 	usermod -G containers -a www-data;\
 	/home/post_build_clean.sh

ADD home home

ADD home/webapps/ /usr/share/tomcat9/webapps

ENV ContUser www-data
ENV ContGrp www-data