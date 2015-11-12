FROM  engines/servicebase:$release
RUN apt-get -y update;\
	apt-get upgrade -y;\
	/home/no_init.sh ;\
	echo "Y" | adduser -q --disabled-password --home /home/certs -uid 22022 certs;\
	usermod -G containers -a certs ;\
	apt-get -y install openssl;\
	apt-get clean

  

COPY home home
COPY sudoers /etc/sudoers.d/engine
RUN 	mkdir -p /home/certs/saved /home/certs/store/ca /home/certs/store/keys /home/certs/store/certs /home/certs/home;\
		chown certs -R /home/certs/saved /home/certs/store/ /home/configurators/saved/ /home/certs/home
ENV HOME /home/certs/home
USER certs

CMD ["/home/start.sh"]