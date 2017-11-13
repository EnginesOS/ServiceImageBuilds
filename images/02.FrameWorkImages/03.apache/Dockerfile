FROM engines/frameworkbase:$release

RUN /usr/sbin/usermod -u 22671 www-data &&\
	apt-get install -y apache2 &&\
	rm etc/apache2/sites-enabled/* &&\
	mkdir -p /etc/apache2/ \ 
	         /var/run/apache2 \  
	         /var/run/apache2/lock &&\
	chown www-data /var/run/apache2 &&\
	usermod -G containers -a www-data &&\
 	/home/post_build_clean.sh

ADD src/000-default.conf /etc/apache2/sites-enabled/
ADD src/ports.conf /etc/apache2/
ADD src/envvars /etc/apache2/envvars
ADD home home

ENV ContUser www-data
ENV ContGrp www-data
ENV APACHE_LOCK_DIR /var/run/apache2/lock/
