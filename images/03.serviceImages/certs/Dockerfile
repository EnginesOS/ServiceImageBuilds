FROM  engines/servicebase:$release
RUN apt-get -y update;\
	echo "Y" | adduser -q --disabled-password --home /home/certs -uid 22022 certs;\
	usermod -G containers -a certs ;\
	apt-get -y install openssl;\
	apt-get clean ;\

  

COPY home home
COPY sudoers /etc/sudoers.d/engine
USER certs

CMD ["/home/start.sh"]