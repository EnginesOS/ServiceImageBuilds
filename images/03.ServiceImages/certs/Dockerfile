FROM  engines/servicebase:$release

RUN /home/engines/scripts/build/no_init.sh &&\
	groupadd -g 22022 certs &&\
	useradd -u 22022  -g certs -d /home/certs -m -G containers certs&&\
	apt-get -y install openssl mailtuils &&\
 	/home/engines/scripts/build/post_build_clean.sh

COPY home home
COPY sudoers /etc/sudoers.d/certs
COPY src/openssl.cnf /etc/ssl/

RUN mkdir -p /home/certs/saved /home/certs/store/ca /home/certs/store/keys /home/certs/store/certs /home/certs/home &&\
	chown certs -R /home/certs/saved /home/certs/store/ /home/engines/scripts/configurators/saved/ /home/certs/home &&\
	chgrp -R containers /home/engines/scripts/actionators/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

	
ENV HOME /home/certs/home
ENV ContUser certs

USER certs

CMD ["/home/engines/scripts/system/start.sh"]