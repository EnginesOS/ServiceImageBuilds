FROM engines/openjdk8:$release

RUN  apt-mark unhold tzdata ;\
	/usr/sbin/usermod -u 22671 www-data;\
	apt-get update -y ;\
	apt-get install -y   tomcat8 ;\
	ln -s /var/log/tomcat8 /usr/share/tomcat8/logs;\
 	ln -s  /etc/tomcat8  /usr/share/tomcat8/conf;\
 	ln -s /tmp /usr/share/tomcat8/temp ;\
 	usermod -G containers -a www-data;\
 	/home/post_build_clean.sh

ADD home home

ADD home/webapps/ /usr/share/tomcat8/webapps

ENV ContUser www-data
ENV ContGrp www-data