FROM engines/frameworkbase:$release

RUN /usr/sbin/usermod -u 22671 www-data;\
	apt-get update -y;\
	apt-get install -y  apache2 ;\
	apt-get clean ;\
	rm etc/apache2/sites-enabled/*;\
	mkdir -p /etc/apache2/ /var/run/apache2;\
	mkdir /home/rlog; \
	chown syslog /home/rlog;\
	chown www-data /var/run/apache2	;\
	usermod -G containers -a www-data


ADD 000-default.conf /etc/apache2/sites-enabled/
ADD ports.conf /etc/apache2/

ENV ContUser www-data
ENV ContGrp www-data