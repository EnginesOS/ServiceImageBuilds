FROM  engines/servicebase:$release
RUN apt-get -y update;\
	echo "Y" | adduser -q --disabled-password --home /home/wwwstats -uid 22024 wwwstats;\	
	usermod -G containers -a wwwstats ;\
	apt-get -y install  apache2  build-essential gcc make zlib1g-dev libpng12-dev libgd-dev
	
RUN cd /tmp; \
  	wget ftp://ftp.mrunix.net/pub/webalizer/webalizer-2.23-08-src.tgz;\
  	tar -xzpf webalizer-2.23-08-src.tgz;\
  	cd webalizer-2.23-08;\
  	./configure --enable-dns --enable-bz2 --enable-geoip ;\
  	make;\
  	make install DESTDIR=/usr/local/
  	
RUN apt-get -y remove  build-essential gcc make ;\
	apt-get -y clean 

ADD 000-default.conf /etc/apache2/sites-enabled/ 

COPY home home

USER wwwstats

CMD ["/home/start.sh"]