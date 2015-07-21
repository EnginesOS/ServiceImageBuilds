FROM  engines/servicebase:$release
RUN apt-get -y update;\
	echo "Y" | adduser -q --disabled-password --home /home/certs -uid 22022 certs;\
	usermod -G containers -a certs ;\
	apt-get -y install openssl;\
	apt-get clean

  

COPY home home
COPY sudoers /etc/sudoers.d/engine
RUN 	mkdir -p /home/certs/saved /home/certs/store/ca /home/certs/store/keys /home/certs/store/certs ;\
		chown certs /home/certs/saved /home/certs/store/ /home/configurators/saved/ca_setup
USER certs

CMD ["/home/start.sh"]