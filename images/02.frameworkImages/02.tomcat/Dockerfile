FROM engines/frameworkbase:$release

RUN apt-get -y  --force-yes update;\
	/usr/sbin/usermod -u 22671 www-data;\
	apt-get install -y  --force-yes  tomcat7 ;\
	apt-get clean ;\
	ln -s /var/log/tomcat7 /usr/share/tomcat7/logs;\
 	ln -s  /etc/tomcat7  /usr/share/tomcat7/conf;\
 	ln -s /tmp /usr/share/tomcat7/temp;\
 	usermod -G containers -a www-data

ADD home home

ADD home/webapps/ /usr/share/tomcat7/webapps

ENV ContUser www-data
ENV ContGrp www-data