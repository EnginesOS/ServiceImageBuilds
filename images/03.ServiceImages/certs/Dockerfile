FROM  engines/servicebase:$release
RUN /home/no_init.sh &&\
	echo "Y" | adduser -q --disabled-password --home /home/certs -uid 22022 certs &&\
	usermod -G containers -a certs &&\
	apt-get -y install openssl &&\
 	/home/post_build_clean.sh

  

COPY home home
COPY sudoers /etc/sudoers.d/engine
COPY openssl.cnf /etc/ssl/
RUN mkdir -p /home/certs/saved /home/certs/store/ca /home/certs/store/keys /home/certs/store/certs /home/certs/home &&\
	chown certs -R /home/certs/saved /home/certs/store/ /home/configurators/saved/ /home/certs/home &&\
	chgrp -R containers /home/actionators/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/
	
	#echo '[ v3_req ]' >> /etc/ssl/openssl.cnf;\
	#echo 'subjectAltName =  DNS:$ENV::ALTNAME' >> /etc/ssl/openssl.cnf
	
ENV HOME /home/certs/home
USER certs
ENV ContUser certs
CMD ["/home/start.sh"]