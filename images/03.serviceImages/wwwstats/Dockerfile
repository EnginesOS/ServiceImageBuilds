FROM  engines/servicebase:$release
RUN apt-get -y update;\
	 usermod www-data -u 22024 ;\
	usermod -G containers -a www-data ;\
	mkdir -p /home/wwwstats/output /var/run/apache2;\
	chown www-data -R /home/wwwstats /var/run/apache2;\ 
	apt-get -y install apache2  build-essential gcc make zlib1g-dev libpng12-dev libgd-dev
	
RUN cd /tmp; \
  	wget ftp://ftp.mrunix.net/pub/webalizer/webalizer-2.23-08-src.tgz;\
  	tar -xzpf webalizer-2.23-08-src.tgz;\
  	cd webalizer-2.23-08;\
  	./configure --enable-dns --enable-bz2 --enable-geoip ;\
  	make;\
  	make install 
  	
RUN apt-get -y remove  build-essential gcc make ;\
	apt-get -y clean 

ADD 000-default.conf /etc/apache2/sites-enabled/ 
ADD ports.conf /etc/apache2/
COPY home home

USER www-data

CMD ["/home/start.sh"]