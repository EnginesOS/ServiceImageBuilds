FROM engines/frameworkbase:$release
ADD home home

RUN /usr/sbin/usermod -u 22671 www-data &&\
	apt-get install -y apache2 &&\
	rm etc/apache2/sites-enabled/* &&\
	mkdir -p /etc/apache2/ \ 
	         /var/run/apache2 \  
	         /var/run/apache2/lock &&\
	chown www-data /var/run/apache2 &&\
	usermod -G containers -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh


ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data

ENV APACHE_PID_FILE /var/run/engines/apache2$SUFFIX.pid
ENV APACHE_RUN_DIR /var/run/engines
ENV APACHE_LOCK_DIR /var/run/
ENV APACHE_LOG_DIR /var/log/


ADD src/000-default.conf /etc/apache2/sites-enabled/
ADD src/ports.conf /etc/apache2/
ADD src/envvars /etc/apache2/envvars

ENV ContUser www-data
ENV ContGrp www-data

